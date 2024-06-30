//
//  ShoesCellView.swift
//  26123
//
//  Created by ewan decima on 14/03/2024.
//

import SwiftUI

struct ShoesCellView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    var shoes : FetchedResults<Shoes>.Element
    
    var body: some View {
        VStack(alignment: .leading,spacing: 6) {
            Text(shoes.brand!)
                .bold()
            
            getNameSize(shoes: shoes)
            
        }
        Spacer()
        Text(shoes.priceStr! + " €" ).foregroundColor(.black)
       
    }
    
    
    private func getNameSize(shoes: Shoes) -> Text{
        var size : String = " US"
        if shoes.size > 20{
            size = " EU"
        }
        return Text(shoes.name! + " " + String(shoes.size) + size).foregroundColor(.gray)
        
    }
}

