//
//  EditSellApparelView.swift
//  26123
//
//  Created by ewan decima on 03/03/2023.
//

import SwiftUI

struct EditSellApparelView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    
    var apparel : FetchedResults<Apparel>.Element
    
    @State private var newsellvalueStr: String = ""
    @State private var newsellwebsite: String = ""
    @State private var newselldate: Date = Date.now
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    Text(apparel.brand!).bold() + Text( " " + apparel.name! + " ") + Text(apparel.size!).font(.caption)
                }
                
                Section{
                    TextField("Prix de Vente", text: $newsellvalueStr)
                        .keyboardType(.numberPad)
                        .onAppear{
                            newsellvalueStr = String(apparel.sellvalue)
                            newsellwebsite = apparel.sellwebsite!
                            newselldate = apparel.selldate!
                            
                        }
                    TextField("Nouveau site de vente", text: $newsellwebsite)
                }
                
                Section{
                    VStack{
                        DatePicker("Date de Vente", selection: $newselldate)
                            .datePickerStyle(GraphicalDatePickerStyle())
                        
                    }

                }
                
                HStack{
                    Button("OK"){
                        DataController().editSellApparel(apparel: apparel,
                                                         newsellvalue: Double(newsellvalueStr)!,
                                                         newsellwebsite: newsellwebsite,
                                                         newselldate: newselldate,
                                                         context: managedObjContext)
                        dismiss()
                    }
                }
                
                
                
            }
            
        }
        .navigationTitle("Modification")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing){
                Button{
                    DataController().editSellApparel(apparel: apparel,
                                                   newsellvalue: Double(newsellvalueStr)!,
                                                   newsellwebsite: newsellwebsite,
                                                   newselldate: newselldate,
                                                   context: managedObjContext)
                    
                    dismiss()
                    
                } label:{
                    Label("Ok", systemImage: "checkmark.circle")
                    
                }
            }
        }
        
        
    }
    
    
    
    
}

