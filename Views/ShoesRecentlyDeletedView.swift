//
//  ShoesRecentlyDeletedView.swift
//  26123
//
//  Created by ewan decima on 17/03/2024.
//

import SwiftUI

struct ShoesRecentlyDeletedView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.jour, order: .reverse)]) var shoes : FetchedResults<Shoes>
    
    @State private var raiseAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            
            VStack{
                if DataController().shoesRecentlyDeletedNumber(shoes: shoes) == 0 {
                    Text("Aucune Sneakers")
                        .bold()
                }
                else {
                    List {
                        ForEach(DataController().allRecentlyDeletedShoes(shoes: shoes), id: \.self){ shoesItem in
                            
                            HStack{
                                
                                ShoesRecentlyDeletedCellView(shoesRecentlyDeleted: shoesItem)
                                
                            }
                            .swipeActions(edge: .leading, allowsFullSwipe: true){
                                Button("Récupérer") {
                                    DataController().removeShoesFromDeleteRecentlyState(shoes: shoesItem, context: managedObjContext)
                                    if DataController().shoesRecentlyDeletedNumber(shoes: shoes) == 0 {
                                        dismiss()
                                    }
                                }
                                .tint(.blue)
                            }
                            
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button("Supprimé définitivement") {
                                    DataController().deleteShoes(shoes: shoesItem, context: managedObjContext)
                                    if DataController().shoesRecentlyDeletedNumber(shoes: shoes) == 0 {
                                        dismiss()
                                    }
                                }
                                .tint(.red)
                            }
                            
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                let recentlyDeletedShoes = DataController().allRecentlyDeletedShoes(shoes: shoes)
                                let shoesToDeletePermanently = recentlyDeletedShoes[index]
                                DataController().deleteShoes(shoes: shoesToDeletePermanently, context: managedObjContext)
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("Supprimé récemment")
            
            
            
           
            
        }
    }
}


