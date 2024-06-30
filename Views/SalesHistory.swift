//
//  SalesHistory.swift
//  26123
//
//  Created by ewan decima on 15/01/2023.
//

import SwiftUI

struct SalesHistory: View {
    @Environment(\.managedObjectContext) var managedObjContext
  
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.selldate, order: .reverse)]) var shoes : FetchedResults<Shoes>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.selldate, order: .reverse)]) var apparel : FetchedResults<Apparel>
    
    @State private var selectedHistory: String = "sneakers"
    @State private var showPremium: Bool = false
    
    
    
    
    var body: some View {
        NavigationStack{
            ScrollView{
                if selectedHistory == "sneakers"{
                    if shoesSoldCount() > 0 {
                        //MARK: ForEach SHOES
                        ForEach(shoes){ shoes in
                            Group{ if shoes.sellvalue != 0{
                                
                                ShoesSalesCellView(shoes: shoes)
                                
        
                                    
                                }
                            }
                        }
                    } else {
                        EmptyHistoryView(itemCategory: "sneakers")
                    }
                    
                    
                }
                else{
                    if apparelSoldCount() > 0 {
                        //MARK: ForEach APPAREL
                        ForEach(apparel){ apparel in
                            Group{ if apparel.sellvalue != 0{
                                ApparelSalesCellView(apparel: apparel)
                                    
                                }
                                
                            }
                                
                            }
                        
                    } else {
                        EmptyHistoryView(itemCategory: "apparel")
                    }
                   
                    
                }
                
               
                }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    VStack{
                        Picker("historique", selection: $selectedHistory) {
                            Image(systemName: "shoe")
                                .tag("sneakers")
                            Image(systemName: "tshirt")
                                .tag("apparel")
                            
                        }
                        .pickerStyle(.segmented)
                    }
                   
                }
                
                //MARK: Logo
                ToolbarItem(placement: .navigationBarLeading){
                    Button{
                        // showPremium.toggle()
                    } label:{
                        Image("logo.icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        
                    }
                }
                
            }
            .sheet(isPresented: $showPremium) {
               PremiumView()
            }
            .navigationTitle("Historique")
            
                
            }
            
        }
        
    
    private func shoesSoldCount()->Int{
        var out: Int = 0
        for shoe in shoes{
            if shoe.sellvalue > 0{
                out += 1
            }
        }
        return out
    }
    
    private func apparelSoldCount()->Int{
        var out: Int = 0
        for item in apparel{
            if item.sellvalue > 0{
                out += 1
            }
        }
        return out
    }
    
    private func shoesGreenOrRedColor(shoes: Shoes)-> Text {
        if shoes.sellvalue - Double(shoes.priceStr!)! > 0 {
            return Text("+" + String(shoes.sellvalue - Double(shoes.priceStr!)!) + "€").foregroundColor(.green)
        }
        else{
            return Text(String(shoes.sellvalue - Double(shoes.priceStr!)!) + "€").foregroundColor(.red)
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
    private func getImage(shoes: Shoes)-> UIImage{
    
        let image = UIImage(data: shoes.imageShoes!)!
        return image
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


