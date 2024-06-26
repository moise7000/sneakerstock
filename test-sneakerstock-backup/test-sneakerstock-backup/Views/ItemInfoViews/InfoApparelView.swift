//
//  InfoApparelView.swift
//  26123
//
//  Created by ewan decima on 25/02/2023.
//

import SwiftUI
import CoreData


struct InfoApparelView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    
    var apparel : FetchedResults<Apparel>.Element
    
    @State private var showingSellView = false
    
    
    
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    HStack{
                        //MARK: Image
                        GetApparelImage(apparel: apparel, radius: 150)
        
                        VStack{
                            Text(apparel.brand! + " " + apparel.name!).bold()
                            Text(apparel.size!)
                        }
                        
                    }
                    
                }
                
                
                
                Section{
                    Text("Prix d'Achat" + " " + String(apparel.buyvalue) + "€")
                    Text("Prix de Vente Estimé" + " " + String(apparel.sellestimatedvalue) + "€")
                }
                
                HStack{
                    Text("Modifier")
                        .bold()
                        .foregroundColor(.red)
                    
                    Spacer()
                    NavigationLink {
                        EditApparelView(apparel: apparel)
                    } label:{
                        Text("")
                    }
                    .padding()
                    .foregroundColor(.red)
                }
                
                Button {showingSellView.toggle()}label: {Text("Vendre").bold()}.sheet(isPresented: $showingSellView) {
                    SellApparelView(apparel: apparel)
                    
                }
                
            }
        }
        .navigationBarTitle(Text(apparel.brand! + " " + apparel.name!))
    }
}

