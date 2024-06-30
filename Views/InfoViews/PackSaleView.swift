//
//  PackSaleView.swift
//  26123
//
//  Created by ewan decima on 27/08/2023.
//

import SwiftUI

struct PackSaleView: View {
    
    @FetchRequest(sortDescriptors: []) var shoes : FetchedResults<Shoes>
    
    var websites =  ["StockX",
                     "Vinted",
                     "Alias",
                     "Wethenew",
                     "Autre"
                     
                  
    ]
    
    var body: some View {
        
        //MARK: Sellwebsite
        NavigationStack{
            VStack{
                ScrollView{
                    LazyVGrid(columns: [.init(), .init()]){
                        ForEach(websites, id:\.self){website in
                           
                            GroupBox(website){
                               
                                ProgressBar(value: getDataForWebsiteCircle(website: website), color: Color.pink)
                            }
                            .padding()
                            //.scaledToFit()
                        }
                    }
                }
            }
        }
        .navigationTitle("Ventes")
    }
    private func nbsale() -> Int{
        var result : Int = 0
        for shoe in shoes {
            if shoe.sellvalue != 0{
                result += 1
            }
        }
        return result
    }
    
    private func getDataForWebsiteCircle(website:String) -> Double{
        var out: Double = 0
        
        for item in shoes{
            if item.sellwebsite == website {
                out += 1
            }
        }
        if nbsale() != 0{
            out = out / Double(nbsale())
        }
        
        return out
        
    }
    
    
}

#Preview {
    PackSaleView()
}
