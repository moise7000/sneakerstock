//
//  ShoesBySizeView.swift
//  26123
//
//  Created by ewan decima on 12/03/2023.
//

import SwiftUI

struct ShoesBySizeView: View {
    
    let shoes : FetchedResults<Shoes>
    
    var idShoesValid: Array<UUID>
    
    var currentSize: String
    
    
    
    
    var body: some View {
        let title: String = currentSize + " " + getCountry(size: Double(currentSize)!)
        NavigationStack{
            ScrollView{
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
                    Text(String(lengthArray(a:idShoesValid)))
                        .foregroundColor(.pink)
                }

                
                //MARK: Share
                ToolbarItem(placement: .navigationBarTrailing){
                    ShareLink(Text("Partager"),item: getAllShoesBySizeToShare(size: currentSize) )
                }
                
                                
                
            }
            
   
        }.navigationTitle(title)
    }
    
    
    //MARK: private func
    
    private func expression(shoes: Shoes)-> String{
        return "-" + shoes.brand! + " " + shoes.name! + " " + String(shoes.size) + "\n"
    }
    
    private func getAllShoesBySizeToShare(size: String)->String{
        var out : String = "\(size): \n"
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
    
    private func getCountry(size: Double) -> String{
        if size > 18{
            return "EU"
        } else {
            return "US"
        }
    }

    
}


