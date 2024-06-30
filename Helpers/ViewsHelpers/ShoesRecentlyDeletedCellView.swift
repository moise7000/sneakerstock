//
//  ShoesRecentlyDeletedCellView.swift
//  26123
//
//  Created by ewan decima on 18/03/2024.
//

import SwiftUI

struct ShoesRecentlyDeletedCellView: View {
    
    var shoesRecentlyDeleted : FetchedResults<Shoes>.Element
    
    var body: some View {
        
        HStack  {
            //MARK: Image
            HStack{
                if shoesRecentlyDeleted.imageShoes != nil {
                    Image(uiImage: getImage(shoes: shoesRecentlyDeleted))
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fit)
                        
                }
            }
            .frame(width: 100, height: 100)
            
            //MARK: Shoes Info
            VStack {
                Text(shoesRecentlyDeleted.name!)
                getsize(shoes: shoesRecentlyDeleted)
            }
            Spacer()
            
            //MARK: Days until deleting permently
            
            
            if DataController().getDaysUntilDelete(shoes: shoesRecentlyDeleted) >= 0 {
                HStack{
                    Text(String(DataController().getDaysUntilDelete(shoes: shoesRecentlyDeleted)))
                        .bold()
                    Text("Jours")
                }
                .foregroundColor(getDaysColor(days: DataController().getDaysUntilDelete(shoes: shoesRecentlyDeleted)))
                
        }
        
        
            
            
        }
    }
    
    private func getDaysColor(days: Int) -> Color {
        if days <= 3 {
            return .red
        }
        return .black
        
    }
    
    private func getImage(shoes: Shoes) -> UIImage {
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

