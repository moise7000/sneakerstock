//
//  TestListTrié.swift
//  26123
//
//  Created by ewan decima on 15/01/2023.
//

import SwiftUI
import CoreData

struct myShoesListView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.jour, order: .reverse)]) var shoes : FetchedResults<Shoes>
    
    @State private var notSoldShoes : [Shoes] = []
    
    @EnvironmentObject var vm: AppViewModel
    
    @State private var query = ""
    @State private var showingAddView = false
    @State private var showingScannerView = false
    @State private var image: UIImage?
    
    @State private var showingScannerAlert = false
    @State private var showPremium : Bool = false
    
    @State private var showingRecentlyDeleteView: Bool = false
    
    
    
    
    var body: some View {
        
        
        
        NavigationStack{
            VStack{
                if DataController().totalShoes(shoes: shoes) > 0 {
                    List {
                        ForEach(DataController().allUnsoldShoes(shoes: shoes), id: \.self){ shoesItem in
                            
                            NavigationLink(destination:  InfoShoesView(shoes:shoesItem)) {
                                HStack{
                                    GetShoesImage(shoes: shoesItem, radius : 90)
                                    ShoesCellView(shoes: shoesItem)
                                }
                            }
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                let unsoldShoes = DataController().allUnsoldShoes(shoes: shoes)
                                let shoesToDelete = unsoldShoes[index]
                                //DataController().deleteShoes(shoes: shoesToDelete, context: managedObjContext)
                                DataController().setShoesToDeleteRecently(shoes: shoesToDelete, context: managedObjContext)
                            }
                            
                            
                        }
                    }
                    .listStyle(.plain)
                }
                else {
                    EmptyListView(itemCategory: "sneakers")
                }
                
                
                
                
            }
            .alert(isPresented: $showingScannerAlert){
                
                Alert(title: Text("Oops ?"),
                      message: Text("Ce modèle d'Iphone n'est pas compatible avec cette fonctionnalité"))
            }
            .searchable(text: $query,  placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Nom")
            .onChange(of:  query){ newValue in shoes.nsPredicate = searchPredicate(query: newValue)}
            .navigationTitle("Sneakers")
            .toolbar {
                //MARK: Logo
                ToolbarItem(placement: .navigationBarLeading){
                    Button{
                        //showPremium.toggle()
                        print("logo pressed")
                    } label:{
                        Image("logo.icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        
                    }
                }
                
                //MARK: Share
                ToolbarItem(placement: .navigationBarLeading) {
                    ShareLink(Text("Partager"), item: getAllShoes())
                }
                

                //MARK: Recently deleted
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button{
                        DataController().deleteShoesToDelete2(shoes: shoes, context: managedObjContext)
                        showingRecentlyDeleteView.toggle()
                    } label: {
                        Label("Recently deleted", systemImage: "trash")
                    }
                        
                }
                
                //MARK: Add
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    }
                    label :{
                        Label("Add", systemImage: "plus.circle")
                    }
                }
                
                    
                    
                    
                    
                
                
//                .sheet(isPresented: $showingScannerView)
//                {
//                    ScanShoesView()
//                        .environmentObject(vm)
//                        .task{
//                            await vm.requestDataScannerAccessStatus()
//                        }
//                }
                                
            }
            .sheet(isPresented: $showingAddView) {
                AddShoesView()
            }
            .sheet(isPresented: $showPremium) {
               PremiumView()
            }
            .sheet(isPresented: $showingRecentlyDeleteView) {
                ShoesRecentlyDeletedView()
            }
            
            .navigationViewStyle(.stack)
            
            
        }
        
       
    }
        
        
        
        
        //MARK: Func
        
        
        
    
        
        private func showScanAlert() -> Void{
//            if vm.dataScannerAccessStatus != . scannerAvailable{
//                showingScannerAlert.toggle()
//                
//            }else{
//                NavigationLink{ScanShoesView()} label:{Label("",systemImage: "")}
//                //showingScannerView.toggle()
//            }
            
        }
        
        private func searchPredicate(query: String) -> NSPredicate? {
            if query == "" { return nil }
            return NSPredicate(format: "%K CONTAINS %@",#keyPath(Shoes.name),query)
        }
        
        private func getNameSize(shoes: Shoes) -> Text{
            var size : String = " US"
            if shoes.size > 20{
                size = " EU"
            }
            return Text(shoes.name! + " " + String(shoes.size) + size).foregroundColor(.gray)
            
        }
        
        private func getExpressionForShoes(item: Shoes)-> String{
            return "-" + item.brand! + " " + item.name! + " " + String(item.size) + "\n"
        }
        
        private func getAllShoes() -> String{
            var out : String = ""
            for item in shoes {
                if item.sellvalue == 0{
                    out += getExpressionForShoes(item: item)
                }
            }
            return out
        }
        
        private func getImage(shoes: Shoes)-> UIImage{
            if UIImage(data: shoes.imageShoes!) != nil{
                return  UIImage(data: shoes.imageShoes!)!
            }
            else {
                return UIImage(systemName: "icloud.slash")!
                
            }
        }
        
        
        
        private func debug1(){
            for x in shoes{
                if x.sellvalue == 0{
                    print(x.name!)
                }
            }
        }
        
        
        
        
        

        private func deleteShoes(offsets: IndexSet) {
            withAnimation {
                offsets.map { shoes[$0] }
                    .forEach(managedObjContext.delete)
                DataController().save(context: managedObjContext)
            }
        }
    }
    
    

