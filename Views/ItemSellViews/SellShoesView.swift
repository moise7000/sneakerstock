//
//  SellShoesView.swift
//  26123
//
//  Created by ewan decima on 12/01/2023.
//

import Foundation
import SwiftUI
import CoreData


struct SellShoesView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    
    var shoes : FetchedResults<Shoes>.Element
    
    @State private var sellvalue : Double = 0
    @State private var sellvalueString = ""
    @State private var sellwebsite = "StockX"
    @State private var showAlert = false
    
    @State private var selectedWebsite : String = ""
    @State private var otherSelectedWebsite : String = ""
    
    var websites =  ["",
                    "StockX",
                     "Vinted",
                     "Alias",
                     "Wethenew",
                     "Autre"
                     
                  
    ]
    
   
    
    var body: some View {
        VStack{
            
            HStack{
                //MARK: Shoes photo
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
                
                //MARK: Shoes info
                VStack{
                    Text(shoes.brand!).bold()
                    Text(shoes.name! + " " + String(shoes.size))
                    
                    
                    getDate(date: shoes.jour!).bold()
                    Text(shoes.priceStr! + " €")
                }
                
            }
            .padding()
            .background{
                RoundedRectangle(cornerRadius: 10, style:.continuous)
                    .fill(.white.shadow(.drop(radius: 0.5)))
                
            }
            
            VStack{
                
                TextField("Prix de vente", text: $sellvalueString)
                    .keyboardType(.numberPad)
                    .padding()
                    .background{
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(.white.shadow(.drop(radius: 1)))
                
                    
                    }
                
                HStack{
                    //MARK: Website
                    VStack{
                        Picker("Website", selection: $selectedWebsite) {
                            ForEach(websites, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                    
                    if selectedWebsite == "Autre"{
                        TextField("Détails", text: $otherSelectedWebsite)
                            .padding()
                            .background{
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .fill(.white.shadow(.drop(radius: 1)))


                            }
                    }
                    
                    //MARK: Sell Button
                    VStack{
                        Button("Ok"){
                            myCondition()
                            
                           
                        }.alert(isPresented: $showAlert){
                            Alert(title: Text("Oops ?"),
                                    message: Text("Il en manque"))
                        }
                    }
                    .padding()
                    .background{
                        RoundedRectangle(cornerRadius: 15, style: .continuous)
                            .fill(.white.shadow(.drop(radius: 2)))

                    }
                    Spacer()

                }
                .padding()
                
            }
            
            
        }
                
        
        
        
        
        
        
        
        
        
        
    }
    private func getImage(shoes: Shoes)-> UIImage{
        if UIImage(data: shoes.imageShoes!) != nil {
            return UIImage(data: shoes.imageShoes!)!
        }
        else {
            return UIImage(systemName: "icloud.slash")!
        }
    
       
    }
    
    
    private func myCondition(){
        if sellvalueString == "" || selectedWebsite == "" {
            showAlert = true
        }
        else {
            var website = selectedWebsite
            if website == "Autre"{
                website = otherSelectedWebsite
            }
            
            sellvalue = Double(sellvalueString)!
            print(sellvalue)
            DataController().sellShoes(shoes:shoes,
                                       sellvalue: sellvalue,
                                       sellwebsite: website,
                                       context: managedObjContext)
            
        
            dismiss()
            
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
    
    private func getDate(date: Date) -> Text{
        return Text(date, style:.date)
    }
    
  
        
    }
    

