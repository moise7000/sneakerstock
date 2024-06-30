//
//  EmptyListView.swift
//  26123
//
//  Created by ewan decima on 23/08/2023.
//

import SwiftUI

struct EmptyListView: View {
    
    var itemCategory: String
    
    var body: some View {
        VStack{
            Text("Vous n'avez ajouté aucun élément.")
                .bold()
            Spacer()
            HStack{
                Text("Tapez sur")
                Image(systemName: "plus.circle")
                    .foregroundColor(.blue)
                Text("en haut à droite")
            }
            Spacer()
        }
        .padding()
        
       
    }
}

