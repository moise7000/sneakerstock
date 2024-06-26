//
//  myApparelListView.swift
//  26123
//
//  Created by ewan decima on 25/02/2023.
//

import SwiftUI
import CoreData

struct myApparelListView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.buydate, order: .reverse)]) var apparel : FetchedResults<Apparel>
    
    @State private var query = ""
    @State private var showingAddView = false
    
    
    var body: some View {
        NavigationStack{
            VStack{
                if DataController().totalApparels(apparels: apparel) > 0{
                    List{
                        ForEach(apparel.filter { $0.sellvalue == 0 }, id: \.self){ apparel in
                            NavigationLink(destination:  InfoApparelView(apparel:apparel)){
                                HStack{
                                    //MARK: Image
                                    GetApparelImage(apparel:apparel, radius: 120)
                                    
                                    
                                    
                                    VStack{
                                        getBrand(apparel: apparel)
                                        getNameSize(apparel: apparel)
                                    }
                                    Spacer()
                                    Text(String(apparel.buyvalue) + "€")
                                    
                                }
                            }
                            
                        }
                        .onDelete(perform: deleteApparel)
                    }
                    .listStyle(.plain)
                    
                }
                else{
                    EmptyListView(itemCategory: "apparel")
                }
                
                
                
            }
            .searchable(text: $query,  placement: .navigationBarDrawer(displayMode: .automatic), prompt: "Nom")
            .onChange(of:  query){ newValue in apparel.nsPredicate = searchPredicate(query: newValue)}
            .navigationTitle("Apparel")
            .toolbar {
                
                //MARK: Logo
                ToolbarItem(placement: .navigationBarLeading){
                    Image("logo.icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }
                
                //MARK: Share
                ToolbarItem(placement: .navigationBarLeading){
                    ShareLink(Text("Partager"), item: getAllApparel())
                }
                
                
                //MARK: Add
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label :{
                        Label("Add", systemImage: "plus.circle")
                    }
                }
                
                
                
                
            }
            .sheet(isPresented: $showingAddView) {
                AddApparelView()
            }
            
        }
    }
    
    
    
    private func getBrand(apparel: Apparel) -> Text{
        return Text(apparel.brand!).bold()
    }
    
    private func getNameSize(apparel: Apparel) -> Text{
        return Text(apparel.name! + " " + apparel.size!).foregroundColor(.gray)
    }
    
    private func getExpressionForApparel(item: Apparel)-> String{
        return "-" + item.brand! + " " + item.name! + " " + item.size! + "\n"
    }
    
    private func getAllApparel() -> String{
        var out : String = ""
        for item in apparel {
            if item.sellvalue == 0{
                out += getExpressionForApparel(item: item)
            }
        }
        return out
    }
    
    private func searchPredicate(query: String) -> NSPredicate? {
        if query == "" { return nil }
        return NSPredicate(format: "%K CONTAINS %@",#keyPath(Apparel.name),query)
    }
    
    
    private func deleteApparel(offsets: IndexSet) {
        withAnimation {
            offsets.map { apparel[$0] }
                .forEach(managedObjContext.delete)
            
            DataController().save(context: managedObjContext)
        }
        
    }
   
    
}

