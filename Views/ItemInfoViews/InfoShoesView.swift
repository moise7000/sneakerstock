//
//  info.swift
//  26123
//
//  Created by ewan decima on 27/12/2022.
//

import SwiftUI
import CoreData


struct InfoShoesView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    
    var shoes : FetchedResults<Shoes>.Element
    
    
    
    @State private var image: UIImage?
    
    @State private var showingSellView = false
    
    
    @State private var showingAddFastView = false
    
    
    var body: some View {
        NavigationStack{
            Form{
                HStack{
                    if shoes.imageShoes != nil{
                        Image(uiImage: getImage(shoes: shoes))
                    }
                }
                
                Section{
                    Text(getShoesExpression())
                        .bold()
                    
                    //MARK: Price
                    HStack{
                        Label("", systemImage:"bag")
                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [ .red, .pink]), startPoint: .leading, endPoint: .trailing))
                            .bold()
                        Text(String(shoes.priceStr ?? "deleted") + " €")
                    }
                    
                    //MARK: ressellPrice
                    HStack{
                        Label("", systemImage:"cart.badge.questionmark")
                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [ .red, .pink]), startPoint: .leading, endPoint: .trailing))
                            .bold()
                        Text(String(shoes.ressellPrice ?? "deleted") + " €")
                    }
                    
//                    if shoes.depositId != nil {
//                        HStack{
//                            Image(systemName: "mappin.and.ellipse")
//                                .foregroundStyle(LinearGradient(gradient:Gradient(colors: [ .red, .pink]),
//                                                                startPoint: .leading,
//                                                                endPoint: .trailing))
//                                .bold()
//                            Text(getDepositFromShoes(shoes: shoes, deposits: deposits)!.name!)
//                        }
//                    }
                    
                    HStack{
                        Label("", systemImage: "link")
                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [ .red, .pink]), startPoint: .leading, endPoint: .trailing))
                            .bold()
                        let setShoesNameForUrl = setStringForUrl(shoes.stockxStyle ?? "deleted")
                        let urlString:String = "https://stockx.com/search?s=\(setShoesNameForUrl)"
                    
                        Link("StockX.com", destination: URL(string: urlString)!)
                    }
                }
                    
                    
                    
                    
                    Section{
                        HStack{
                            Text("Modifier")
                                .bold()
                                .foregroundColor(.red)
                            
                            Spacer()
                            NavigationLink {
                                EditShoesView(shoes:shoes)
                            } label:{
                                Text("")
                            }
                            //.padding()
                            .foregroundColor(.red)
                        }
                        Button {
                            showingSellView.toggle()
                        }label: {
                            Text("Vendre").bold()
                            
                        }.sheet(isPresented: $showingSellView) {
                            SellShoesView(shoes: shoes)
                            
                        }
                    }
                    
//                    Section("Premium"){
//                        Button{
//                            showingAddFastView.toggle()
//                        } label:{
//                            Label("Ajout rapide", systemImage: "plus.circle")
//                        }
//                        .sheet(isPresented: $showingAddFastView) {
//                            PremiumAddFastView(shoes: shoes)
//                            
//                        }
//                        
//                    }
                    
                    
                    
                }
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        ShareLink(Text("partager"), item: getInfoShoesToShare())
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button{
                            showingAddFastView.toggle()
                        } label :{
                            Label("ajout rapide", systemImage: "plus.circle")
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button{
                            DataController().deleteShoes(shoes: shoes, context: managedObjContext)
                            dismiss()
                        } label : {
                            Label("delete", systemImage: "trash")
                        }
                    }
                }
                
            }
            .navigationBarTitle(Text(shoes.name ?? ""))
            
        }
    
    private func getShoesExpression() -> String {
        var out: String = shoes.brand ?? ".."
        out += " "
        out += shoes.name ?? ".."
        out += String(shoes.size) ?? ".."
        return out
    }
        
    private func getInfoShoesToShare()->String{
        var out: String  = shoes.brand ?? ""
        out += " "
        out += shoes.name ?? ""
        out += " "
        out += String(shoes.size) ?? ""
        out += shoes.ressellPrice ?? ""
        out += "€" + "\n Prix d'achat "
        out += String(shoes.priceStr ?? "")
        out += "€"
            
            return out
        }
        
        
        private func getsize(shoes:Shoes) -> Text {
            let shoesSizeString = String(round((shoes.size * 100))/100)
            if shoes.size > 20{
                return Text("\(shoesSizeString) EU")
            }
            else {
                return Text("\(shoesSizeString) US")
                
            }
        }
        
        
        
        private func getImage(shoes: Shoes)-> UIImage {
            if UIImage(data: shoes.imageShoes!) != nil {
                return UIImage(data: shoes.imageShoes!)!
            }
            else {
                return UIImage(systemName: "icloud.slash")!
            }
            
            
        }
        
        
        
        
    }

