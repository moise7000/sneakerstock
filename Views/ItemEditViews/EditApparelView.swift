//
//  EditApparelView.swift
//  26123
//
//  Created by ewan decima on 26/02/2023.
//

import SwiftUI

struct EditApparelView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    
    var apparel : FetchedResults<Apparel>.Element
    
    @State private var sizes = ["XS", "S", "M", "L","XL", "+XL"]
    
    @State private var brand : String = ""
    @State private var name : String = ""
    @State private var size : String = ""
    @State private var selectedSize : String = ""
    @State private var buyvalueStr : String = ""
    @State private var sellestimatedvalueStr : String = ""
    
     
    
    var body: some View {
        
        Form{
            Section{
                TextField(apparel.brand!, text: $brand)
                    .onAppear{
                        brand = apparel.brand!
                        name = apparel.name!
                        selectedSize = apparel.size!
                        buyvalueStr = String(apparel.buyvalue)
                        sellestimatedvalueStr = String(apparel.sellestimatedvalue)
                        
                    }
                TextField(apparel.name!, text: $name)
                
                VStack {
                    Picker("Taille", selection: $selectedSize) {
                        ForEach(sizes, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                TextField("Prix d'Achat", text : $buyvalueStr)
                    .keyboardType(.numberPad)
                
                TextField("Prix de Vente Estimé", text : $sellestimatedvalueStr)
                    .keyboardType(.numberPad)
                
                
                HStack{
                    Spacer()
                    Button("OK") {
                        DataController().editApparel(apparel: apparel,
                                                     name: name,
                                                     brand: brand,
                                                     size: selectedSize,
                                                     buyvalue: Double(buyvalueStr)!,
                                                     sellestimatedvalue: Double(sellestimatedvalueStr)!,
                                                     context: managedObjContext)
                        dismiss()
                    }
                    Spacer()
                }

                
            }
        }
    }
}

