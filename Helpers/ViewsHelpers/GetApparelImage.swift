//
//  GetImage.swift
//  26123
//
//  Created by ewan decima on 14/06/2023.
//

import SwiftUI
import CoreData

struct GetApparelImage: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    var apparel : FetchedResults<Apparel>.Element
    var radius : CGFloat
    
    var body: some View {
        
        HStack{
            if apparel.image != nil {
                Image(uiImage: getImageFromData(data: apparel.image!))
                    .resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fit)
            }
        }
        .clipShape(Circle())
        .frame(width: radius, height: radius)
    }
}


