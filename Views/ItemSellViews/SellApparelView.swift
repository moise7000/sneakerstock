//
//  SellApparelView.swift
//  26123
//
//  Created by ewan decima on 26/02/2023.
//

import SwiftUI

struct SellApparelView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    
    var apparel : FetchedResults<Apparel>.Element
    
    @State private var showAlert = false
    
    @State private var selectedWebsite = ""
    @State private var sellvalueString = ""
    @State private var sellvalue : Double = 0
    
    var websites =  ["",
                    "StockX",
                     "Vinted",
                     "Alias",
                     "Wethenew",
                     "Autre"]
    
    var body: some View {
        HStack{
            //MARK: Apparel photo
            HStack{
                if apparel.image != nil {
                    Image(uiImage: getImageFromData(data: apparel.image!))
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fit)
                }
            }
            .clipShape(Circle())
            .frame(width: 150, height: 150)
            //MARK: Apparel info
            VStack{
                Text(apparel.brand!).bold()
                Text(apparel.name!)
                Text(apparel.size!)
                
            }
            
            
            
            //MARK: Buy info
            VStack{
                Text(apparel.buydate!, style:.date)
                Text(String(apparel.buyvalue) + " €")
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
                Picker("website", selection: $selectedWebsite) {
                    ForEach(websites, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.wheel)
                
                //MARK: Sell Button
                VStack{
                    Button("Ok"){
                        myCondition()
                        dismiss()
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

                
                
                
            }
            
            
        }
        
        
        
                
    }
    
    
    
    private func myCondition(){
        if sellvalueString == "" || selectedWebsite == ""{
            showAlert = true
        }
        else {
            sellvalue = Double(sellvalueString)!
            DataController().sellApparel(apparel: apparel, sellvalue: sellvalue, sellwebsite: selectedWebsite, context: managedObjContext)
            
            dismiss()
            
        }
    }
    
    
    
    
    
    
}

