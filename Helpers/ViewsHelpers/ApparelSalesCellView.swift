//
//  ApparelSalesCellView.swift
//  26123
//
//  Created by ewan decima on 18/03/2024.
//

import SwiftUI

struct ApparelSalesCellView: View {
    var apparel : FetchedResults<Apparel>.Element
    
    var body: some View {
        VStack {
            HStack{
                //MARK: apparel image
                HStack{
                    if apparel.image != nil {
                        Image(uiImage: getImageFromData(data: apparel.image!))
                            .resizable()
                            .scaledToFit()
                            .aspectRatio(contentMode: .fit)
                    }
                }
                .clipShape(Circle())
                .frame(width: 75, height: 75)
                
                
                getDate(date: apparel.selldate!).bold()
                apparelGreenOrRedColor(apparel:apparel)
                Spacer()
                NavigationStack{
                    NavigationLink(destination: InfoSaleApparelView(apparel: apparel)){
                        Text("Voir")
                    }
                }
                .navigationTitle(Text("Historique"))
                    
                }
            
            Spacer()
            
            HStack {
                Label("" , systemImage: "tshirt.fill")
                    .font(.caption)
                
                
                Text(apparel.name!)
                    .font(.caption)
                        
                Spacer()
                Text(apparel.size!)
                    .font(.caption)
                        
                Spacer()
                Label(String(apparel.buyvalue) + "€" , systemImage: "bag")
                    .font(.caption)
                Spacer()
                Label(String(apparel.sellvalue) + "€" , systemImage: "cart")
                    .font(.caption)
                Spacer()
            }
        }
        .padding()
        .background{
            RoundedRectangle(cornerRadius: 10, style:.continuous)
                .fill(.white.shadow(.drop(radius: 1.5)))
            
        }
        
        
    }
    private func apparelGreenOrRedColor(apparel: Apparel)-> Text {
        let benefit = apparel.sellvalue - apparel.buyvalue
        if benefit > 0 {
            return Text("+" + String(benefit) + "€").foregroundColor(.green)
        }
        else{
            return Text(String(benefit) + " €").foregroundColor(.red)
        }
        
    }
    
    private func getDate(date: Date) -> Text {
        return Text(date, style:.date)
    }
}


