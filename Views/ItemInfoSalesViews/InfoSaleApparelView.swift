//
//  InfoSaleApparelView.swift
//  26123
//
//  Created by ewan decima on 03/03/2023.
//

import SwiftUI

struct InfoSaleApparelView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    
    var apparel : FetchedResults<Apparel>.Element
    
    var body: some View {
        Form{
            Section{
                HStack{
                    //MARK: Apparel image
                    HStack{
                        if apparel.image != nil {
                            Image(uiImage: getImageFromData(data: apparel.image!))
                                .resizable()
                                .scaledToFit()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                    .clipShape(Circle())
                    .frame(width: 200, height: 200)
                    
                    //MARK: Apparel Info
                    VStack{
                        Text(apparel.brand!).bold()
                        Text(String(apparel.name!))
                        Text(apparel.size!)
                        
                    }
                    
                }
                
                //MARK: Achat
                HStack{
                    Label("", systemImage: "bag")
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [ .red, .pink]), startPoint: .leading, endPoint: .trailing))
                        .bold()

                    getDate(date: apparel.buydate!)
                        .font(.caption)
                    Spacer()
                    Text(String(apparel.buyvalue) + " €")
                }
                
                
                //MARK: Revente
                HStack{
                    Label("", systemImage: "cart")
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [ .red, .pink]), startPoint: .leading, endPoint: .trailing))
                        .bold()

                    getDate(date: apparel.selldate!)
                        .font(.caption)
                    Spacer()
                    Text(String(apparel.sellvalue) + " €")
                }
                
                //MARK: Website
                HStack{
                    Label("", systemImage: "network")
                        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [ .red, .pink]), startPoint: .leading, endPoint: .trailing))
                        .bold()

                    Spacer()
                    getWebsite(apparel: apparel)
                        .foregroundColor(.pink)
                        .bold()
                        
                    
                }
  
            }
            //MARK: Bénéfice
            HStack{
                Label("", systemImage: "eurosign")
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [ .red, .pink]), startPoint: .leading, endPoint: .trailing))
                    .bold()

                Spacer()
                greenOrRedColor(apparel: apparel)
                    .font(.title)
            }
            
            
        }
        .toolbar{
            
            //MARK: Edit
            ToolbarItem(placement: .navigationBarTrailing){
                NavigationStack{
                    NavigationLink(destination: EditSellApparelView(apparel:apparel)){
                        Label("Modifer", systemImage: "eraser")
                    }
                }.navigationTitle("Info de Vente")
            }
            
            //MARK: Delete
            ToolbarItem(placement: .navigationBarTrailing){
                Button{
                    DataController().editSellApparel(apparel: apparel, newsellvalue: 0, newsellwebsite: "", newselldate: Date.now, context: managedObjContext)
                    dismiss()
                } label: {
                    Label("Supprimer la Vente",systemImage: "trash")
                        .foregroundColor(.red)
                }
            }
            
            
            
            
            
        }
    }
    
    //MARK: functions
    
    private func getDate(date: Date) -> Text{ // ok
        return Text(date, style:.date)
    }
    private func getWebsite(apparel:Apparel) -> Text{ //ok 
        if apparel.sellwebsite != nil{
            return Text(String(apparel.sellwebsite!))
        }
        else {
            return Text("Non Renseigné")
        }
    }
    
    private func greenOrRedColor(apparel: Apparel) -> Text{
        let benefit = apparel.sellvalue - apparel.buyvalue
        if benefit > 0{
            return Text("+" + String(benefit) + " €").foregroundColor(.green)
        }
        else {
            return Text(String(benefit) + " €").foregroundColor(.red)
        }
    }
    
    
}
