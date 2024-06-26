//
//  GearView.swift
//  26123
//
//  Created by ewan decima on 24/11/2023.
//

import SwiftUI

struct GearView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest(sortDescriptors: []) var deposits : FetchedResults<Deposit>
    
    
    var body: some View {
        NavigationStack{
            Form {
                HStack{
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [ .red, .pink]), startPoint: .leading, endPoint: .trailing))
                        .bold()
                    Text("Les Dépot-Ventes")

                    NavigationLink {
                        //DepositView()
                    } label:{
                        Text("")
                    }
                }
            }
            .navigationTitle("Réglages")
        }
    }
    
    
    
}
