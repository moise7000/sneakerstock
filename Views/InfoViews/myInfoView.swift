//
//  myInfo.swift
//  26123
//
//  Created by ewan decima on 28/12/2022.
//

import SwiftUI
import CoreData

import Charts


struct myInfoView: View {
    
    @Environment(\.managedObjectContext) var managedObjContext
    
    @FetchRequest(sortDescriptors: []) var shoes : FetchedResults<Shoes>
    @FetchRequest(sortDescriptors: []) var apparel : FetchedResults<Apparel>
    
    @State private var currentSalePeriod: String = "7J"
    @State private var currentBenefitPeriod: String = "7J"
    
    @State private var showUserView : Bool = false
    @State private var showPremium : Bool = false
    @State private var showGearView: Bool = false
    
    var abs = [1,2, 3, 4]
    var ord = [1, 2, 3, 3]
   
    
 
    
    var brands = ["Nike",
                   "Air Jordan",
                   "Adidas",
                   "Converse",
                   "New Balance",
                    "Supreme",
                   "Salomon",
                   "Reebok",
                   "Yeezy",
                   "Autre"
    ]
    var websites =  ["StockX",
                     "Vinted",
                     "Alias",
                     "Wethenew",
                     "Autre"
                     
                  
    ]
    
   
    var body: some View {
     
        
        NavigationStack{
            ScrollView{
                Spacer()
                
                
                GroupBox("Ventes"){
                    VStack{
                        HStack{
                            Picker("", selection: $currentSalePeriod){
                                Text("7J")
                                    .tag("7J")
                                Text("2S")
                                    .tag("2S")
                                Text("5S")
                                    .tag("5S")
                                Text("13S")
                                    .tag("13S")
                                Text("26S")
                                    .tag("26S")
                                
                    
                            }
                            .pickerStyle(.segmented)
                        }
                        
                        if currentSalePeriod == "7J"{
                            let myAbs = xtime(period: 7)
                            ChartBarDay(myAbs: myAbs, color: Color.pink, myFunc: totalSalesByDay, width:300, height:145)
                            
                        }
                        
                        if currentSalePeriod == "2S"{
                            let myAbs = xtime(period: 14)
                            ChartBarDay(myAbs: myAbs, color: Color.pink, myFunc: totalSalesByDay, width:300, height:145)
                        }
                        
                        if currentSalePeriod == "5S"{
                            let myAbs = xtime(period: 35)
                            ChartBarMonth(myAbs: myAbs, color: Color.pink, myFunc: totalSalesByDay, width:300, height:145)
                        }
                        
                        if currentSalePeriod == "13S"{
                            let myAbs = xtime(period: 91)
                            ChartBarMonth(myAbs: myAbs, color: Color.pink, myFunc: totalSalesByDay, width:300, height:145)
                        }
                        
                        if currentSalePeriod == "26S"{
                            let myAbs = xtime(period: 182)
                            ChartBarMonth(myAbs: myAbs, color: Color.pink, myFunc: totalSalesByDay, width:300, height:145)
                        }
                        
                      


                        
                    }
                    
                    //MARK: Go to SaleDetailView
                    HStack{
                        Spacer()
                        NavigationLink{
                            SalesDetailView()
                        } label:{
                            Text("Détails")
                        }
                    }
                    
                    
                }
                .padding()
                .scaledToFit()
                
                
                
                
                VStack{
                    HStack{
                        //MARK: Benefit
                        VStack{
                            HStack{
                                Text("Bénéfice")
                                    .foregroundColor(.black).bold()
                                Spacer()
                            }
                           
                            
                            Text(convertDoubleToLisibleString(x:totalItemRealBenefits()))
                                .foregroundColor(.black).bold()
                                .font(.largeTitle)
                            
                            HStack{
                                //Text("+" + String(totalItemEstimatedBenefits()) + " €")
                                   // .foregroundColor(.gray)
                                Text("Estimé")
                                    .foregroundColor(.gray)
                            }
                            
                        }
                        .padding()
                        .background{
                            RoundedRectangle(cornerRadius: 10, style:.continuous)
                                .fill(.white.shadow(.drop(radius: 1.5)))
                            
                        }
                        
                        
                        //MARK: StockValue
                        VStack{
                            HStack{
                                Text("Valeur du Stock")
                                    .foregroundColor(.black).bold()
                                Spacer()
                            }
                            
                            Text(convertDoubleToLisibleString(x:Double(totalShoesPrices())!))
                                .foregroundColor(.black).bold()
                                .font(.largeTitle)
                            
                
                            HStack{
                                Text(String(totalShoes()))
                                    .foregroundColor(.gray)
                                    
                                Text("Paires")
                                    .foregroundColor(.gray)
                                
                            }
                            
                            
                        }
                        
                        .padding()
                        .background{
                            RoundedRectangle(cornerRadius: 10, style:.continuous)
                                .fill(.white.shadow(.drop(radius: 1.5)))
                        }

                        
                    }
                    
                    

                    
                }
                .padding()
                
                
                
                
                
                //MARK: ChartBar
                GroupBox("Bénéfices"){
                    
                    VStack{
                            if currentSalePeriod == "7J"{
                                let myAbs = xtime(period: 7)

                                ChartBarDay(myAbs: myAbs, color: Color.green, myFunc: totalSalesBenefitByDay, width:300, height:60)
                            }
                        
                            if currentSalePeriod == "2S"{
                                let myAbs = xtime(period: 14)
                                ChartBarDay(myAbs: myAbs, color: Color.green, myFunc: totalSalesBenefitByDay, width:300, height:60)
                            }

                            if currentSalePeriod == "5S"{
                                let myAbs = xtime(period: 35)
                                ChartBarMonth(myAbs: myAbs, color: Color.green, myFunc: totalSalesBenefitByDay, width:300, height:60)

                            }

                            if currentSalePeriod == "13S"{
                                let myAbs = xtime(period: 91)
                                ChartBarMonth(myAbs: myAbs, color: Color.green, myFunc: totalSalesBenefitByDay, width:300, height:60)
                            }
                        
                        if currentSalePeriod == "26S"{
                            let myAbs = xtime(period: 182)
                            ChartBarMonth(myAbs: myAbs, color: Color.green, myFunc: totalSalesBenefitByDay, width:300, height:60)
                        }
                    
                    }
                    
                
                    
                    //MARK: Go to BenefitDetailView
                    HStack{
                        Spacer()
                        NavigationLink{
                            BenefitsDetailView()
                        } label:{
                            Text("Détails")
                        }
                    }
                }
                .padding()
                .scaledToFit()
               
                
                //MARK: PACK By ... 
                HStack{
                    NavigationStack{
                        NavigationLink(destination: PackBrandView()) {
                            TextRectangle(message: "Details des Marques")
                        }
                    }
                    
                    NavigationStack{
                        NavigationLink(destination: PackSizeView()) {
                            TextRectangle(message:"Details des Tailles")
                        }
                    }
                    
                    NavigationStack{
                        NavigationLink(destination: PackSaleView()) {
                            TextRectangle(message:"Details des Ventes")
                        }
                    }
                    
                }
                
                
                


              
            }
            .navigationTitle("Info")
            .toolbar {
                //ToolbarItem(placement: .navigationBarTrailing){
//                    Button{
//                        showUserView.toggle()
//                        
//
//                    } label :{
//                        Image(systemName:"person.circle")
//                        
//                    }
//                }
                
                ToolbarItem(placement: .navigationBarLeading){
                    Button{
                        //showPremium.toggle()
                    } label:{
                        Image("logo.icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        
                    }
                }
//                ToolbarItem(placement: .topBarTrailing){
//                    Button{
//                        showGearView.toggle()
//                    } label:{
//                        Label("",systemImage: "gear")
//                    }
//                }
            }
            .sheet(isPresented: $showGearView) {
               GearView()
            }
            .sheet(isPresented: $showPremium) {
               PremiumView()
            }
            .sheet(isPresented: $showUserView) {
               UserView()
            }
                
        }
        
        
        
    }
    //MARK: chart function test
    
    
   private func helloworld(date: Date, dayNumberIPeriod: Int)->Bool{
        let minuteSinceDate  = Int(date.timeIntervalSinceNow)/60
        let hourSinceDate = minuteSinceDate/60
        let daySinceDate  = Int(hourSinceDate/24)
        
        
        return daySinceDate < dayNumberIPeriod
    }
    
    private func xtime(period: Int)->Array<Date>{
        var xdate : [Date] = []
        for shoe in shoes{
            if shoe.sellvalue > 0 && isValidToDisplayBool(date: shoe.selldate!, dayNumberIPeriod: period){
                xdate.append(shoe.selldate!)
            }
            
        }
        for appa in apparel{
            if appa.sellvalue > 0 && isValidToDisplayBool(date: appa.selldate!, dayNumberIPeriod: period){
                xdate.append(appa.selldate!)
                
            }
        }
        return Array(Set(xdate))
    }
    
    private func ySalestime()-> Array<Double>{
        let xdate = xtime(period: 100)
        var yDouble: [Double] = []
        for xD in xdate {
            yDouble.append(totalSalesByDay(sellday: xD))
        }
        return yDouble
        
    }
    
    private func yBenefitTime() -> Array<Double>{
        let xDate = xtime(period: 100)
        var yDouble: [Double] = []
        for xD in xDate {
            yDouble.append(totalSalesBenefitByDay(sellday: xD))
        }
        return yDouble
    }
    
    
    
      
    //MARK: Shoes function
    
    private func allShoesSize() -> Array<Double> { //ok
        var out: Array<Double> = []
        for shoe in shoes{
            if shoe.sellvalue == 0{
                out.append(shoe.size)
            }
        }
        return Array(Set(out))
    }
    
    private func packShoesBySize(size: String) -> Array<UUID>{ //ok
        var out: Array<UUID> = []
        for shoe in shoes {
            if shoe.sellvalue == 0 && String(shoe.size) == size{
                out.append(shoe.id!)
            }
        }
        return out
    }
    
    private func packShoesByBrand(brand: String) -> Array<UUID> { //ok
        var out: Array<UUID> = []
        for shoe in shoes{
            if shoe.sellvalue == 0 && shoe.brand! == brand{
                out.append(shoe.id!)
            }
        }
        return out
    }
    
    
    private func shoesNumberByBrand(brand: String) -> Int{ //ok
        let packshoes = packShoesByBrand(brand: brand)
        return lengthArray(a: packshoes)
    }
    
    private func shoesNumberBySize(size: Double) -> Int{ //ok
        var out: Int = 0
        for shoe in shoes{
            if shoe.sellvalue == 0 && shoe.size == size{
                out += 1
            }
        }
        return out
    }
    
    private func totalShoes() -> Int{ //ok
        var number : Int = 0
        for shoe in shoes {
            if DataController().isShoesValidFromConditions(shoe, from: DataController().CONDITIONS) {
                number += 1
            }
        }
        return number
    }
    
    
    private func totalShoesPrices() -> String{ //ok
        var price: Double = 0
        for item in shoes {
            if item.sellvalue == 0 && !item.isInDeletingRecentlyState{
                if Double(item.priceStr!) != nil{
                    price += Double(item.priceStr!)!                //ERROR HERE need to handle with sku is missing on stockx
                }
               
            }
            
        }
        return String(round(price * 100)/100)
    }
    
    private func totalRessellPrices() -> String{//ok
        var resselPrice : Double = 0
        for item in shoes {
            if item.sellvalue == 0{
                resselPrice += Double(item.ressellPrice!)!
            }
        }
        return String(round(resselPrice * 100)/100)
    }
    
    private func totalShoesEstimatedBenefits() -> Double{ //ok
        var benefit : Double = 0
        for item in shoes{
            if item.sellvalue == 0 && !item.isInDeletingRecentlyState{
                let itemPrice = Double(item.priceStr!)!
                let itemRessellPrice = Double(item.ressellPrice!) ?? 0
                let itemBenefit = itemRessellPrice - itemPrice
                benefit += itemBenefit
            }
            
        }
        return benefit
    }
    
    private func totalShoesRealBenefits() -> Double{ //ok
        var benefit : Double = 0
        for item in shoes{
            if item.sellvalue != 0{
                let itemPrice = Double(item.priceStr!)!
                let itemBenefit = item.sellvalue - itemPrice
                benefit += itemBenefit
            }
            
        }
        return benefit
    }
    
    
    //MARK: Apparel function
    
    private func totalApparel() -> Int{ // ok
        var number : Int = 0
        for appa in apparel {
            if appa.sellvalue == 0 {
                number += 1
            }
        }
        return number
    }

    private func totalApparelPrices() -> String{ // ok
        var price: Double = 0
        for appa in apparel {
            if appa.sellvalue == 0{
                price += appa.buyvalue
            }
            
        }
        return String(price)
    }
    
    private func totalStockPrices() -> Double{ //ok
        let price = Double(totalShoesPrices())! + Double(totalApparelPrices())!
        return price
    }
    
    private func totalApparelEstimatedBenefits() -> Double{ //ok
        var benefit : Double = 0
        for item in apparel{
            if item.sellvalue == 0{
                let itemBenefit = item.sellestimatedvalue - item.buyvalue
                benefit += itemBenefit
            }
        }
        return benefit
    }
    
    private func totalApparelRealBenefits() -> Double{//ok
        var benefit : Double = 0
        for item in apparel{
            if item.sellvalue != 0{
                let itemBenefit = item.sellvalue - item.buyvalue
                benefit += itemBenefit
            }
        }
        return benefit
    }
    
    //MARK: Global Stock function
    
    private func nbsale() -> Int{ //ok
        var result : Int = 0
        for shoe in shoes {
            if shoe.sellvalue != 0{
                result += 1
            }
        }
        return result
    }
    
    private func totalItemEstimatedBenefits() -> Double{
        return totalShoesEstimatedBenefits() + totalApparelEstimatedBenefits()
    }
    
    private func totalItemRealBenefits() -> Double{
        return totalShoesRealBenefits() + totalApparelRealBenefits()
    }
    
    
    
    //MARK: data function

    private func salesShoesByDay(sellday: Date) -> Double{   // fonctions à revoir -> creer les donnees dans une liste [x,y]
        var result : Double = 0
        
        for shoe in shoes {
            let selldate = shoe.selldate!
            if selldate == sellday {
                result += Double(shoe.sellvalue)
            }
        }
        return result
    }
    
    private func salesShoesByDay2(sellday: Date) -> Double{   // fonctions à revoir -> creer les donnees dans une liste [x,y]
        var result : Double = 0
        
        for shoe in shoes {
            let selldate = shoe.selldate!
            if selldate == sellday {
                result += Double(shoe.sellvalue)
            }
        }
        
        for appa in apparel{
            let selldate = appa.selldate!
            if selldate == sellday{
                result += appa.sellvalue
            }
        }
        
        return result
    }
    
    
    
    private func benefitShoesByDay(sellday: Date) -> Double{  // fonctions à revoir -> creer les donnees dans une liste [x,y]
        var result : Double = 0
        
        for shoe in shoes {
            let benefit = shoe.sellvalue - Double(shoe.priceStr!)!
            let selldate = shoe.selldate!
            if selldate == sellday{
                result += Double(benefit)
            }
        }
        return result
    }
    
    private func salesApparelByDay(sellday: Date) -> Double{  // fonctions à revoir -> creer les donnees dans une liste [x,y]
        var result : Double = 0
        for appa in apparel{
            if appa.sellvalue > 0{
                let selldate = appa.selldate!
                if selldate == sellday{
                    result += Double(appa.sellvalue)
                }
                
            }
            
        }
        return result
    }
    
    private func benefitApparelByDay(sellday: Date) -> Double{   // fonctions à revoir -> creer les donnees dans une liste [x,y]
        var result : Double = 0
        for appa in apparel{
            if appa.sellvalue > 0{
                let benefit = appa.sellvalue - appa.buyvalue
                let selldate = appa.selldate!
                if selldate == sellday{
                    result += Double(benefit)
                }
                
            }
            
        }
        return result
    }
    
    
    private func totalSalesByDay(sellday: Date ) -> Double{
        return salesShoesByDay(sellday: sellday) + salesApparelByDay(sellday: sellday)
    }
    
    private func totalSalesBenefitByDay(sellday: Date) -> Double{
        return benefitShoesByDay(sellday: sellday) + benefitApparelByDay(sellday: sellday)
    }
    
    
    
    private func getDataForWebsiteCircle(website:String) -> Double{
        var out: Double = 0
        
        for item in shoes{
            if item.sellwebsite == website {
                out += 1
            }
        }
        if nbsale() != 0{
            out = out / Double(nbsale())
        }
        
        return out
        
    }
    
    private func getDataForBrandCircle(brand: String) -> Double{
        var out: Double = 0
        for item in shoes{
            if item.brand == brand && item.sellvalue == 0 {
                out += 1
            }
        }
        if totalShoes() != 0 {
            out = out/Double(totalShoes())
        }
        return out
        
    }
    
    
    
    
    
    
    
    
    
    
    
}
struct PlainGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
            configuration.content
        }
        .padding()
        .background(Color(.systemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}






struct ProgressBar: View {
    var value: Double
    var color: Color = Color.pink
    
    var body: some View{
        ZStack{
            Circle()
                 .opacity(0.05)
                 .foregroundColor(.pink)
            Text(String(round(value * 100)) + "%")
            Circle()
                .trim(from: 0.0, to:value)
                .stroke(style: StrokeStyle(lineWidth: 11.0, lineCap: .round, lineJoin:.round))
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: 270))
                //.animation(.easeInOut(duration: 1.0))
        }
    }
}

struct ProgressBarInteger: View {
    var value: Double
    var color: Color = Color.pink
    var total: Int
    var body: some View{
        ZStack{
            Circle()
                 .opacity(0.05)
                 .foregroundColor(.pink)
            Text(String(Int(value)) + "/" + String(total))
            Circle()
                .trim(from: 0.0, to: value/Double(total))
                .stroke(style: StrokeStyle(lineWidth: 11.0, lineCap: .round, lineJoin:.round))
                .foregroundColor(color)
                .rotationEffect(Angle(degrees: 270))
                //.animation(.easeInOut(duration: 1.0))
        }
    }
}
