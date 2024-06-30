//
//  InfoSaleView.swift
//  26123
//
//  Created by ewan decima on 22/01/2023.
//


import SwiftUI
import CoreData


struct InfoSaleShoesView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    
    var shoes : FetchedResults<Shoes>.Element
    
    @State private var image: UIImage?
    
    @State private var showingSellView = false
    
   

    
    
    var body: some View {
        
        NavigationStack{
            Form{
                Section{
                    HStack{
                        //MARK: Shoes Photo
                        HStack{
                            if shoes.imageShoes != nil{
                                Image(uiImage: getImage(shoes: shoes))
                                    .resizable()
                                    .scaledToFit()
                                    .aspectRatio(contentMode: .fit)
                                    
                            }
                        }
                        //.clipShape(Circle())
                        .frame(width: 180, height: 180)
                        
                        Spacer()
                        
                        //MARK: Shoes Info
                        VStack{
                            Text(shoes.brand!).bold()
                            Text(shoes.name!)
                            getsize(shoes: shoes)
                        }
                        
                    }
                    //MARK: Achat
                    HStack{
                        Label("", systemImage: "bag")
                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [ .red, .pink]), startPoint: .leading, endPoint: .trailing))
                            .bold()
                        getDate(date: shoes.jour!)
                            .font(.caption)
                        Spacer()
                        Text(shoes.priceStr! + " €")
                    }
                    
                    //MARK: Revente
                    HStack{
                        Label("", systemImage: "cart")
                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [ .red, .pink]), startPoint: .leading, endPoint: .trailing))
                            .bold()
                        getDate(date: shoes.selldate!)
                            .font(.caption)
                        Spacer()
                        Text(String(shoes.sellvalue) + " €")
                    }
                    
                    //MARK: Website
                    HStack{
                        Label("", systemImage: "network")
                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [ .red, .pink]), startPoint: .leading, endPoint: .trailing))
                            .bold()
                        Spacer()
                        getWebsite(shoes: shoes)
                            .foregroundStyle(LinearGradient(gradient: Gradient(colors: [ .red, .pink]), startPoint: .leading, endPoint: .trailing))
                            .bold()
                        
                    }
                    
                    
                    
                    
                    
                    
                }
                
                
                HStack{
                    Label("", systemImage: "eurosign")
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [ .red, .pink]), startPoint: .leading, endPoint: .trailing))
                        .bold()
                    Spacer()
                    greenOrRedColor(shoes: shoes)
                        .font(.title)
                    
                    
                }
                
            }
            .navigationTitle("Info de Vente")
            .toolbar{
                
                //MARK: Edit
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationStack{
                        NavigationLink(destination: EditSellShoesView(shoes: shoes)){
                            Label("Modifer", systemImage: "eraser")
                        }
                    }
                }
                
                //MARK: Delete
                ToolbarItem(placement: .navigationBarTrailing){
                    Button{
                        DataController().editSellShoes(shoes: shoes, newsellvalue: 0, newsellwebsite: "", newselldate: Date.now , context: managedObjContext)
                        dismiss()
                    } label: {
                        Label("Supprimer la Vente",systemImage: "trash")
                            .foregroundColor(.red)
                    }
                    
                }
                
                
                
                
                
                
            }
        }
        
        
        
       
        
        
        
    }
            
           
        
    private func getBenefit(shoes: Shoes) -> Text{
        let a = Double(shoes.priceStr!)!
        let b = shoes.sellvalue
        return Text(String(b - a) + "€")
    }
    
    private func getDate(date: Date) -> Text{
        return Text(date, style:.date)
    }
    private func getWebsite(shoes:Shoes) -> Text{
        if shoes.sellwebsite != nil{
            return Text(String(shoes.sellwebsite!))
        }
        else {
            return Text("Non Renseigné")
        }
    }
    
    
    private func getImage(shoes: Shoes)-> UIImage{ //ok
        if UIImage(data: shoes.imageShoes!) != nil {
            return UIImage(data: shoes.imageShoes!)!
        }
        else {
            return UIImage(systemName: "icloud.slash")!
        }
    
       
    }
    
    private func getsize(shoes:Shoes) -> Text{
        let shoesSizeString = String(round((shoes.size * 100))/100)
        if shoes.size > 20{
            return Text("\(shoesSizeString) EU")
        }
        else {
            return Text("\(shoesSizeString) US")
            
        }
    }
    
    private func greenOrRedColor(shoes: Shoes)-> Text{
        if shoes.sellvalue - Double(shoes.priceStr!)! > 0 {
            return Text("+" + String(shoes.sellvalue - Double(shoes.priceStr!)!) + "€").foregroundColor(.green)
        }
        else{
            return Text(String(shoes.sellvalue - Double(shoes.priceStr!)!) + "€").foregroundColor(.red)
        }
        
    }
}
  

    
 
    

