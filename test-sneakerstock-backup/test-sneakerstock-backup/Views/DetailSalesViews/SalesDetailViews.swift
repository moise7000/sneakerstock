//
//  SalesDetailViews.swift
//  26123
//
//  Created by ewan decima on 06/03/2023.
//

import SwiftUI

struct SalesDetailView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
      
    @FetchRequest(sortDescriptors: [SortDescriptor(\.selldate, order: .reverse)]) var shoes : FetchedResults<Shoes>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.selldate, order: .reverse)]) var apparel : FetchedResults<Apparel>
      
    
    
    
    var body: some View {
        let allSalesMonths = differentSalesMonth2()//.reversed()
        
        NavigationStack{
            Form{
                Section("Total"){
                    HStack{
                        Text("Total depuis le début")
                        Spacer()
                        Text(String(DataController().getTotalTurnover(shoes: shoes, apparels: apparel)))
                            .foregroundStyle(.red)
                            .bold()
                    }
                    
                }
                
                ForEach(DataController().getAllSalesYear(shoes: shoes, apparels: apparel), id: \.self) { year in
                    Section(String(year)){
                        //MARK: Year Total
                        HStack{
                            Text("Total sur l'année")
                                .bold()
                            Spacer()
                            Text(String(DataController().getTurnoverByYear(shoes: shoes, apparels: apparel, by: year)))
                                .foregroundStyle(.red)
                                .bold()
                    
                        }
                        
                        
                        ForEach(DataController().getSalesMonthByYear(shoes: shoes, apparels: apparel, by: year), id: \.self) { saleMonth in
                            HStack{
                                Text(saleMonth)
                                Spacer()
                                Text(String(DataController().getTurnoverByMonthAndYear(shoes: shoes, apparels: apparel, month: saleMonth, by: year)))
                            }
                            
                        }
                        
                        
                        
                    }
                    
                }
            }
            .navigationTitle("Récap des Ventes")
        }
        
        
        
        
        

        
    }
    
    
    
    
    
    
    
    
    
    //MARK: Func
    
    private func shoesTurnover()-> Double{ // chiffre d'affaire //ok
        var out : Double = 0
        for shoe in shoes{
            if shoe.sellvalue > 0 {
                out += shoe.sellvalue
            }
            
        }
        return out
    }
    private func apparelTurnover()-> Double{ //ok
        var out : Double = 0
        for item in apparel{
            if item.sellvalue > 0 {
                out += item.sellvalue
            }
            
        }
        return out
    }
    
    
    
    private func totalTurnover() -> Double{ // ok
        return shoesTurnover() + apparelTurnover()
    }
    
    private func salesByMonth(currentMonth: String)-> Double{
        var result: Double = 0
        
        for shoe in shoes{
            if shoe.sellvalue > 0{
                let shoeSaleMonth = getMonthFromDate(date: shoe.selldate!)
                if shoeSaleMonth == currentMonth{
                    result += shoe.sellvalue
                    
                }
            }
        }
        
        for appa in apparel{
            if appa.sellvalue > 0 {
                let appaSaleMonth = getMonthFromDate(date: appa.selldate!)
                if appaSaleMonth == currentMonth{
                    result += appa.sellvalue
                }
            }
        }
        
        
        return result
        
    }
    
    private func nbShoesSellByMonth(currentMonth: String)->Int{
        var nbSale: Int = 0
        for shoe in shoes{
            if shoe.sellvalue > 0{
                let shoeSaleMonth = getMonthFromDate(date: shoe.selldate!)
                if shoeSaleMonth == currentMonth{
                    nbSale += 1
                    
                }
            }
        }
        return nbSale
    }
    
    private func nbApparelSellByMonth(currentMonth: String) -> Int{
        var nbSale: Int = 0
        for appa in apparel{
            if appa.sellvalue > 0 {
                let appaSaleMonth = getMonthFromDate(date: appa.selldate!)
                if appaSaleMonth == currentMonth{
                    nbSale += 1
                }
            }
        }
        return nbSale
    }
    
    
    private func differentSalesMonth()->Array<String>{
        var months: [String] = []
        for shoe in shoes {
            if shoe.sellvalue > 0{
                let newElement = getMonthFromDate(date: shoe.selldate!)
                months.append(newElement)
                
            }
        }
        for appa in apparel {
            if appa.sellvalue > 0{
                let newElement = getMonthFromDate(date: appa.selldate!)
                months.append(newElement)
            }
        }
        return Array(Set(months))
    }

    
    
    
    
    private func differentSalesMonth2()->Array<String>{
        var monthString: [String] = []
        var months:[Date] = []
       
        
        for shoe in shoes {
            if shoe.sellvalue > 0{
                let newElement = getMonthFromDate(date: shoe.selldate!)
                monthString.append(newElement)
                months.append(shoe.selldate!)
                
            }
        }
        
        for appa in apparel {
            if appa.sellvalue > 0{
                let newElement = getMonthFromDate(date: appa.selldate!)
                monthString.append(newElement)
                months.append(appa.selldate!)
                
            }
        }
        
        let out  = getMonthFromDateArray(arr: sortArrayDate(arr: months))
      
       
        return setStringArray(a: out)
    }
    
    
}


