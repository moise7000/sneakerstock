//
//  GetShoesImage.swift
//  26123
//
//  Created by ewan decima on 19/06/2023.
//

import SwiftUI

struct GetShoesImage: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    
    var shoes : FetchedResults<Shoes>.Element
    var radius : CGFloat
   
    
    
    var body: some View {
        HStack{
            if shoes.imageShoes != nil{
                Image(uiImage: getImageFromData(data: shoes.imageShoes!))
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
                    
            }
        }
        .frame(width: radius, height: radius)
    }
}


