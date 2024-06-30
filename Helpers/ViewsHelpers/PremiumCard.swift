//
//  PremiumCard.swift
//  26123
//
//  Created by ewan decima on 21/08/2023.
//

import SwiftUI

struct PremiumCard: View {
    
    var version: String
    var price: String
    var versionInfo: String
    @State private var isSelected: Bool = false
    @State private var colorSelected: Color = Color.black
    
    var body: some View {
        Button{
            isSelected.toggle()
            if isSelected{
                colorSelected = Color.blue
            } else{
                colorSelected = Color.black
            }
            
        } label :{
            
            VStack{
                //MARK: version
                HStack{
                    Text("SneakerStock " + version)
                    Spacer()
                    
                    if !isSelected{
                        Image(systemName: "circle")
                    } else {
                        Image(systemName:"checkmark.circle.fill")
                            .foregroundColor(.blue)
                    }
                    
                }
                
                //MARK: Price
                HStack{
                    Text(price + " € par mois")
                    Spacer()
                }
                
                //MARK:  Version Info
                HStack{
                    Text(versionInfo)
                        .font(.caption)
                    Spacer()
                }
                
            }
            .padding()
            
        }
        .foregroundColor(.black)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(colorSelected, lineWidth: 2)
                
        )
        .padding()
        
    }
}


