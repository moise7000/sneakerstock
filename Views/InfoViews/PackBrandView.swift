//
//  PackBrandView.swift
//  26123
//
//  Created by ewan decima on 27/08/2023.
//

import SwiftUI

struct PackBrandView: View {
    
    @FetchRequest(sortDescriptors: []) var shoes : FetchedResults<Shoes>
    @FetchRequest(sortDescriptors: []) var apparel : FetchedResults<Apparel>
    
    var brands = ["Nike",
                   "Air Jordan",
                   "Adidas",
                   "Converse",
                   "New Balance",
                    "Supreme",
                   "Salomon",
                   "Reebok",
                   "Yeezy",
                   "Autre"
    ]
    
    
    
    var body: some View {
       
        //MARK: Pack by Brand
        NavigationStack{
            VStack{
                ScrollView{
                    LazyVGrid(columns: [.init(), .init()]){
                        ForEach(brands, id: \.self){brand in
                            NavigationLink(destination: ShoesByBrandView(shoes: shoes, idShoesValid: packShoesByBrand(brand: brand), currentBrand: brand) ){
                                GroupBox(brand){
                                    VStack{
                                        Image("\(brand)Logo")
                                            .resizable()
                                            .scaledToFit()
                                            
                                            .cornerRadius(15.0)
                                            .frame(width: 100, height: 100)
                                        Text("\(shoesNumberByBrand(brand: brand))/\(totalShoes())")
                                            .foregroundColor(.red)
                                            .bold()
                                    }
                                    //.padding()
                                   
                                    
                                    
                                        
                                    //ProgressBar(value: getDataForBrandCircle(brand: brand), color: Color.red)
                                }
                                .padding()
                            }
                            
                        }
                        
                    }
                }
            }
        }
        .navigationTitle("Marques en Stock")
        
        
        
        
    }
    private func shoesNumberByBrand(brand: String)->Int{
        let packshoes = packShoesByBrand(brand: brand)
        return lengthArray(a: packshoes)
    }
    
    private func totalShoes() -> Int{
        var number : Int = 0
        for shoe in shoes {
            if shoe.sellvalue == 0 {
                number += 1
            }
        }
        return number
    }
    
    private func packShoesByBrand(brand: String) -> Array<UUID> {
        var out: Array<UUID> = []
        for shoe in shoes{
            if shoe.sellvalue == 0 && shoe.brand! == brand{
                out.append(shoe.id!)
            }
        }
        return out
    }
}




#Preview {
    PackBrandView()
}
