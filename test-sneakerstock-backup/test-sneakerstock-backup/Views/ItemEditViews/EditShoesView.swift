//
//  EditShoesView.swift
//  26123
//
//  Created by ewan decima on 26/12/2022.
//

import SwiftUI

struct EditShoesView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    
    var shoes : FetchedResults<Shoes>.Element
    
    @State private var name = ""
    @State private var brand = ""
    @State private var size : Double = 41
    @State private var price : Double = 100
    @State private var priceStr : String = ""
    @State private var stockxStyle = ""
    
    @State private var ressellPrice = ""
    
    var sizesUS = ["3.5", "4", "4.5", "5", "5.5", "6", "6.5", "7", "7.5", "8", "8.5", "9",
                 "9.5", "10", "10.5", "11", "11.5", "12", "12.5", "13", "13.5", "14", "14.5",
                 "15", "15.5", "16", "16.5", "17", "17.5", "18"]
    
    var sizesEU = ["35","36", "36.5", "37.5", "38", "38.5", "39", "40", "40.5",
                   "41", "42", "42.5", "43", "44", "44.5", "45", "45.5", "46",
                   "47", "47.5", "48.5", "49.5"]
    var country  = ["EU", "US"]
    
    
    var brands = ["Nike",
                   "Air Jordan",
                   "Addidas",
                   "Converse",
                   "New Balance",
                    "Supreme",
                   "Salomon",
                   "Reebok",
                   "Yeezy",
                   "Puma",
                   "Vans"
    ]
    
    
    
    
    @State private var selectedSize = ""
    @State private var selectedCountry = "EU"
    @State private var selectedBrand = "Nike"
    
    
    
    
    var body: some View {
      
        Form {
            Section{
                
                TextField("\(shoes.brand!)",text : $brand)
                    .onAppear {
                        name = shoes.name!
                        brand = shoes.brand!
                        selectedSize = String(shoes.size)
                        price = shoes.price
                        ressellPrice = shoes.ressellPrice!
                        stockxStyle = shoes.stockxStyle!
                        priceStr = shoes.priceStr!
                        
                        
                        
                    }
                TextField("\(shoes.name!)", text: $name)
                
                //TextField("Price", value: $price, format: .number)
                HStack{
                    VStack{
                        Picker("Pays", selection: $selectedCountry) {
                            ForEach(country, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    Spacer()
                    VStack {
                        Picker("Taille", selection: $selectedSize) {
                            ForEach(getSize(), id: \.self) {
                                Text($0)
                            }
                        }
                    }
                    
                }
                TextField("Prix d'Achat", text : $priceStr)
                    .keyboardType(.numberPad)
                Section {
                    //.padding()
                    
                    TextField("\(shoes.stockxStyle!)", text: $stockxStyle)
                    TextField("\(shoes.ressellPrice!)", text: $ressellPrice)
                        .keyboardType(.numberPad)
                }
                
                HStack{
                    Spacer()
                    Button("OK") {
                        DataController().editShoesRessell(shoes: shoes,
                                                          name: name,
                                                          brand: brand,
                                                          size: Double(selectedSize)!,
                                                          price: price,
                                                          priceStr: priceStr,
                                                          ressellPrice: ressellPrice,
                                                          stockxStyle: stockxStyle,
                                                          context: managedObjContext)
                        dismiss()
                    }
                    Spacer()
                }
            }
        }
    }
    private func getSize() -> Array<String>{
        if selectedCountry == "EU"{
            return sizesEU
        }
        else{
            return sizesUS
        }
    }
}


