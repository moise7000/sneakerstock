//
//  PackSizeView.swift
//  26123
//
//  Created by ewan decima on 27/08/2023.
//

import SwiftUI

struct PackSizeView: View {
    
    @FetchRequest(sortDescriptors: []) var shoes : FetchedResults<Shoes>
    
    
    var body: some View {
        
        
        NavigationStack{
            let sizes = allShoesSize()
            VStack{
                ScrollView{
                    LazyVGrid(columns: [.init(), .init()]){
                        ForEach(sizes, id: \.self){size in
                            NavigationLink(destination: ShoesBySizeView(shoes: shoes, idShoesValid: packShoesBySize(size: String(size)), currentSize: String(size)) ){
                                GroupBox(String(size)){
                                    ProgressBarInteger(value: Double(shoesNumberBySize(size: size)), color: Color.red, total: totalShoes())
                                }
                                .padding()
                            }
                            
                        }
                        
                    }
                }
            }
        }
        .navigationTitle("Tailles en Stock")
    }
    
    
    
    //MARK: Function
    
    private func allShoesSize() -> Array<Double> {
        var out: Array<Double> = []
        for shoe in shoes{
            if shoe.sellvalue == 0{
                out.append(shoe.size)
            }
        }
        return Array(Set(out))
    }
    
    private func shoesNumberBySize(size: Double) -> Int{
        var out: Int = 0
        for shoe in shoes{
            if shoe.sellvalue == 0 && shoe.size == size{
                out += 1
            }
        }
        return out
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
    
    private func packShoesBySize(size: String) -> Array<UUID>{
        var out: Array<UUID> = []
        for shoe in shoes {
            if shoe.sellvalue == 0 && String(shoe.size) == size{
                out.append(shoe.id!)
            }
        }
        return out
    }
    
}


