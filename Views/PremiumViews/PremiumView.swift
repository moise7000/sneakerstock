//
//  PremiumView.swift
//  26123
//
//  Created by ewan decima on 16/08/2023.
//

import SwiftUI

struct PremiumView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        
        NavigationStack{
            
            VStack{
                //MARK: Title
                HStack{
                    Image("logo.icon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                    
                    Text("SneakerStock Studio")
                        .bold()
                    
                    Spacer()
                    
                    //MARK: Close Button
                    Button{
                        dismiss()
                    } label: {
                        Image(systemName: "multiply.circle")
                            .foregroundColor(.blue)
                            
                    }
         
                }
                .padding()
                
            
                Spacer()
                
                PremiumCard(version: "Max", price: "0,99", versionInfo: "Lorem Ipsum")
                PremiumCard(version: "Pro", price: "3,99", versionInfo: "Lorem Ipsum")
                PremiumCard(version: "Ultra", price: "4,99", versionInfo: "Lorem Ipsum")
                
                
            }
            
            
            
        }
        
        
        
        
        
    }
}

