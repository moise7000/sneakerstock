//
//  EmptyHistoryView.swift
//  26123
//
//  Created by ewan decima on 23/08/2023.
//

import SwiftUI

struct EmptyHistoryView: View {
    
    var itemCategory: String
    
    var body: some View {
        
        VStack{
            Spacer()
            Text("Vous n'avez effectué aucune ventes")
                .bold()
            Spacer()
        }
        .padding()
        
        Image("logo.icon")
            .resizable()
            .scaledToFit()
            .frame(width: 150, height: 150)
            .padding()
        
    }
}


