//
//  BenefitDetailsView.swift
//  26123
//
//  Created by ewan decima on 07/03/2023.
//

import SwiftUI

struct BenefitsDetailView: View {
    
    
    @Environment(\.managedObjectContext) var managedObjContext
      
    @FetchRequest(sortDescriptors: [SortDescriptor(\.selldate, order: .reverse)]) var shoes : FetchedResults<Shoes>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.selldate, order: .reverse)]) var apparel : FetchedResults<Apparel>
    
    
    
    var body: some View {
        NavigationStack{
            Form{
                Section("Total"){
                    HStack{
                        Text("Total depuis le début")
                        Spacer()
                        Text(String(DataController().totalRealBenefit(shoes: shoes, apparels: apparel)))
                            .foregroundStyle(DataController().totalRealBenefit(shoes: shoes,apparels: apparel).isStPositive())
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
                            Text(String(DataController().getRealBenefitByYear(shoes: shoes, apparels: apparel, by: year)))
                                .foregroundStyle(DataController().getRealBenefitByYear(shoes: shoes, apparels: apparel,by: year).isStPositive())
                                .bold()
                    
                        }
                        
                        
                        ForEach(DataController().getSalesMonthByYear(shoes: shoes, apparels: apparel, by: year), id: \.self) { saleMonth in
                            HStack{
                                Text(saleMonth)
                                Spacer()
                                Text(String(DataController().getRealBenefitByMonthAndYear(shoes: shoes, apparels: apparel, month: saleMonth, by: year)))
                                    .foregroundStyle(DataController().getRealBenefitByMonthAndYear(shoes: shoes, apparels: apparel, month: saleMonth, by: year).isStPositive())
                            }
                            
                        }
                        
                        
                        
                    }
                    
                }
            }
            .navigationTitle("Récap des Bénéfices")
        }
    }
}


