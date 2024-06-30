//
//  ShoesByBrandView.swift
//  26123
////
//  ShoesBySizeView.swift
//  26123
//
//  Created by ewan decima on 12/03/2023.
//

import SwiftUI

struct ShoesByBrandView: View {
    
    let shoes : FetchedResults<Shoes>
    
    var idShoesValid: Array<UUID>
    var currentBrand: String
    
    
    
    var body: some View {
        NavigationStack{
            ScrollView{
//                GroupBox(
//                    label: Label("mes Infos", systemImage: "info.bubble")
//                        .foregroundColor(.pink).bold()
//                        .font(.title)
//                ){
//                    HStack{
//                        Label("Paires", systemImage: "square.stack.3d.up")
//                        Text(String(lengthArray(a: idShoesValid)))
//                            .foregroundColor(.blue)
//
//
//
//                    }
//
//
//
//
//
//                }
//                .padding()
//                .groupBoxStyle(PlainGroupBoxStyle())
                LazyVGrid(columns: [.init(), .init()]){
                    ForEach(shoes){ shoes in
                        if isUUIDArrayUUID(x: shoes.id!, a: idShoesValid){
                            
                            //MARK: Shoes Photo
                            HStack{
                                if shoes.imageShoes != nil{
                                    Image(uiImage: getImage(shoes: shoes))
                                        .resizable()
                                        .scaledToFit()
                                        
                                        .aspectRatio(contentMode: .fit)
                                        
                                }
                            }
                            .frame(width: 90, height: 90)
                            
                            
                        }
                        
                        
                    }
                }
            }
            .toolbar{
                
                //MARK: Count
                ToolbarItem(placement: .navigationBarTrailing) {
                    Text(String(lengthArray(a: idShoesValid)))
                        .foregroundColor(.pink)
                }
  
                //MARK: Share
                ToolbarItem(placement: .navigationBarTrailing){
                    ShareLink(Text("Partager"), item: getgetAllShoesByBrandToShare(brand: currentBrand))
                }
                
                
                
                
                
            }
 
            
        }
        .navigationTitle(currentBrand)
    }
    
    
    //MARK: private func
    private func expression(shoes: Shoes)-> String{
        return "-" + shoes.brand! + " " + shoes.name! + " " + String(shoes.size) + "\n"
    }
    
    private func getgetAllShoesByBrandToShare(brand: String)->String{
        var out : String = "\(brand): \n"
        for shoe in shoes{
            if isUUIDArrayUUID(x: shoe.id!, a: idShoesValid){
                out += expression(shoes:shoe)
            }
        }
        return out
    }
    
    private func getImage(shoes: Shoes)-> UIImage{
        if UIImage(data: shoes.imageShoes!) != nil{
            return  UIImage(data: shoes.imageShoes!)!
        }
        else {
            return UIImage(systemName: "icloud.slash")!
            
        }
    }

    
}


