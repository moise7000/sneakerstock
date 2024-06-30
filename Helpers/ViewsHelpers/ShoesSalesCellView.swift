//
//  ShoesSalesCellView.swift
//  26123
//
//  Created by ewan decima on 18/03/2024.
//

import SwiftUI

struct ShoesSalesCellView: View {
    var shoes : FetchedResults<Shoes>.Element
    
    
    var body: some View {
        
        VStack {
            HStack {
                //MARK: shoes image
                HStack{
                    if shoes.imageShoes != nil{
                        Image(uiImage: getImage(shoes: shoes))
                            .resizable()
                            .scaledToFit()
                            
                            .aspectRatio(contentMode: .fit)
                            
                    }
                }
                .frame(width: 100, height: 100)
                
                getDate(date: shoes.selldate!).bold()
                    shoesGreenOrRedColor(shoes: shoes)
                    Spacer()
                
                NavigationStack{
                    NavigationLink(destination: InfoSaleShoesView(shoes:shoes)){
                        Text("Voir")
                    }

                }.navigationTitle(Text("Historique"))
                                                        
            }
            Spacer()
            HStack {
                Label("", systemImage: "shoeprints.fill")
                    .font(.caption)
                Spacer()
                Text(shoes.name!)
                    .font(.caption)
                        
                Spacer()
                getsize(shoes: shoes)
                    .font(.caption)
                        
                Spacer()
                Label(String(shoes.priceStr!) + "€" , systemImage: "bag")
                    .font(.caption)
                Spacer()
                Label(String(shoes.sellvalue) + "€" , systemImage: "cart")
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
    
    private func getImage(shoes: Shoes)-> UIImage {
        let image = UIImage(data: shoes.imageShoes!)!
        return image
    }
    
    private func getDate(date: Date) -> Text {
        return Text(date, style:.date)
    }
    
    private func shoesGreenOrRedColor(shoes: Shoes)-> Text {
        if shoes.sellvalue - Double(shoes.priceStr!)! > 0 {
            return Text("+" + String(shoes.sellvalue - Double(shoes.priceStr!)!) + "€").foregroundColor(.green)
        }
        else{
            return Text(String(shoes.sellvalue - Double(shoes.priceStr!)!) + "€").foregroundColor(.red)
        }
        
    }
    
    private func getsize(shoes:Shoes) -> Text {
        let shoesSizeString = String(round((shoes.size * 100))/100)
        if shoes.size > 20{
            return Text("\(shoesSizeString) EU")
        }
        else {
            return Text("\(shoesSizeString) US")
            
        }
    }
}


