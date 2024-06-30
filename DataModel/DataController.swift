//
//  DataController.swift
//  26123
//
//  Created by ewan decima on 26/12/2022.
//

import Foundation
import CoreData
import SwiftSoup
import SwiftUI
import UIKit


class DataController: ObservableObject{
    
    
    let container = NSPersistentContainer(name: "Shoes")
    let containerApparel = NSPersistentContainer(name: "Apparel")
    let containerDeposit = NSPersistentContainer(name: "Deposit")
    
    
    init(){
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the dara \(error.localizedDescription)")
            }
        }
        
        containerApparel.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the dara \(error.localizedDescription)")
            }
        }
        
        containerDeposit.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the dara \(error.localizedDescription)")
            }
        }
        
        
    }
    
    
    
    func save(context: NSManagedObjectContext) -> Void {
        do{
            try context.save()
            print("data saved")
             
        } catch {
            print("data not saved, we failed ...")
        }
    }
    
    
    //MARK: Shoes funtions
    
    func addShoes(name: String,
                  brand: String,
                  size: Double,
                  price: Double,
                  priceStr: String,
                  stockxStyle: String,
                  
                  context : NSManagedObjectContext) -> Void {
        let shoes = Shoes(context: context)
        shoes.id = UUID()
        shoes.jour = Date()
        shoes.name = name
        shoes.brand = brand
        shoes.size = size
        shoes.price = price
        shoes.stockxStyle = stockxStyle
        shoes.priceStr = priceStr
        
        
        save(context: context)
    }
    
    func editShoes(shoes: Shoes,
                   name: String,
                   brand: String,
                   size: Double,
                   price: Double,
                   priceStr : String,
                   stockxStyle: String,
                   
                   
                   context: NSManagedObjectContext) -> Void {
        shoes.name = name
        shoes.brand = brand
        shoes.size = size
        shoes.price = price
        shoes.stockxStyle = stockxStyle
        shoes.priceStr = priceStr
        
        
        save(context: context)
    }
    
    func addShoesRessell(name: String,
                         brand: String,
                         size: Double,
                         price: Double,
                         priceStr : String,
                         ressellPrice: String,
                         stockxStyle: String,
                        
                         context : NSManagedObjectContext) -> Void {
        
        let shoes = Shoes(context: context)
        shoes.id = UUID()
        shoes.jour = Date()
        shoes.name = name
        shoes.brand = brand
        shoes.size = size
        shoes.price = price
        shoes.ressellPrice = ressellPrice
        shoes.stockxStyle = stockxStyle
        shoes.priceStr = priceStr
        
        
        getImageData(productID: stockxStyle) { result in
            switch result {
            case .success(let imageData):
                // Faites quelque chose avec les données binaires de l'image
                shoes.imageShoes = imageData
                self.save(context: context)
                print("b data saved")
            case .failure(_):
                // Gérez l'erreur
                print("error")
            }
        }

        
        save(context: context)
    }
    
    func addShoesRessell2(name: String,
                          brand: String,
                          size: Double,
                          price: Double,
                          priceStr : String,
                          ressellPrice: String,
                          stockxStyle: String,
                         
                          context : NSManagedObjectContext) -> Void {
        
        let shoes = Shoes(context: context)
        shoes.id = UUID()
        shoes.jour = Date()
        shoes.name = name
        shoes.brand = brand
        shoes.size = size
        shoes.price = price
        shoes.ressellPrice = ressellPrice
        shoes.stockxStyle = stockxStyle
        shoes.priceStr = priceStr
        
        
        
        let urlString = "https://stockx.com/fr-fr/search?s=\(stockxStyle)"
        scrapeImageDataFromURL(urlString: urlString) { imageData in
            if let imageData = imageData {
                shoes.imageShoes = imageData
                print("Données de l'image récupérées avec succès.")
                self.save(context: context)
                
            } else {
                shoes.imageShoes = nil
                print("Impossible de récupérer les données de l'image.")
            }
        }
        
        
        //MARK: Recently Delete News
        shoes.isInDeletingRecentlyState = false

        
        save(context: context)
    }
    
    func editShoesRessell(shoes: Shoes,
                          name: String,
                          brand: String,
                          size: Double,
                          price: Double,
                          priceStr : String,
                          ressellPrice: String,
                          stockxStyle: String,
                          
                          context: NSManagedObjectContext) -> Void {
        shoes.name = name
        shoes.brand = brand
        shoes.size = size
        shoes.price = price
        shoes.ressellPrice = ressellPrice
        shoes.stockxStyle = stockxStyle
        shoes.priceStr = priceStr
        
        getImageData(productID: stockxStyle) { result in
            switch result {
            case .success(let imageData):
                // Faites quelque chose avec les données binaires de l'image
                shoes.imageShoes = imageData
                self.save(context: context)
                print("b data saved")
            case .failure(_):
                // Gérez l'erreur
                print("error")
                shoes.imageShoes = UIImage(systemName:"aston")?.pngData()
                self.save(context: context)
            }
            
            
            self.save(context: context)
        }
    }
    
    func sellShoes(shoes: Shoes,
                   sellvalue: Double,
                   sellwebsite: String,
                   context: NSManagedObjectContext) -> Void {
        shoes.selldate = Date()
        shoes.sellvalue = sellvalue
        shoes.sellwebsite = sellwebsite
        
        save(context: context)
        
        
        
    }
    
    func editSellShoes(shoes: Shoes,
                       newsellvalue: Double,
                       newsellwebsite: String,
                       newselldate: Date,
                       context: NSManagedObjectContext) -> Void {
        shoes.selldate = newselldate
        shoes.sellvalue = newsellvalue
        shoes.sellwebsite = newsellwebsite
        
        save(context: context)
    }
    
    
    func deleteShoes(shoes: Shoes, context : NSManagedObjectContext) -> Void {
        context.delete(shoes)
        print("shoes deleted")
        save(context: context)
        
    }
    
    func deleteShoesWithoutSaving(shoes: Shoes, context: NSManagedObjectContext) -> Void {
        context.delete(shoes)
    }
    
    func setShoesToDeleteRecently(shoes: Shoes, context: NSManagedObjectContext) -> Void {
        shoes.isInDeletingRecentlyState = true
        shoes.deletingRecentlyDate = Date()
        save(context: context)
    }
    
    func removeShoesFromDeleteRecentlyState(shoes: Shoes, context: NSManagedObjectContext) -> Void {
        shoes.isInDeletingRecentlyState = false
        shoes.deletingRecentlyDate = nil
        save(context: context)
    }
    
    func getDaysUntilDelete(shoes: Shoes) -> Int {
        if shoes.isInDeletingRecentlyState {
            let timeInRecentlyDeleteTrash: Int = 30
            let daySinceNowFromDeleting = dayNumberSinceNow(date: shoes.deletingRecentlyDate!)
            let out: Int = (timeInRecentlyDeleteTrash - daySinceNowFromDeleting) * indicatorFunction(timeInRecentlyDeleteTrash >= daySinceNowFromDeleting)
            return out
            
        } else {
            return -1
        }
    }
    
    func allRecentlyDeletedShoes(shoes:FetchedResults<Shoes>) -> [Shoes] {
        var recentlyDeletedShoes: [Shoes] = []
        for shoe in shoes {
            if shoe.isInDeletingRecentlyState {
                recentlyDeletedShoes.append(shoe)
            }
        }
        return recentlyDeletedShoes
    }
    
    func shoesRecentlyDeletedNumber(shoes:FetchedResults<Shoes>) -> Int {
        return lengthArray(a: allRecentlyDeletedShoes(shoes: shoes))
    }
    
    func shoesHaveToBeDeleted(shoes: Shoes) -> Bool {
        let daysUntilDelete: Int = getDaysUntilDelete(shoes: shoes)
        if daysUntilDelete < 0 {
            return false
        }
        if daysUntilDelete == 0 {
            return true
        }
        return false
    }
    
    func getShoesToDelete(shoes:FetchedResults<Shoes>) -> [Shoes] {
        var shoesToDelete: [Shoes] = []
        for shoe in shoes{
            if shoesHaveToBeDeleted(shoes: shoe) {
                shoesToDelete.append(shoe)
            }
        }
        return shoesToDelete
    }
    
    func shoesToDeleteNumber(shoes:FetchedResults<Shoes>) -> Int {
        return lengthArray(a: getShoesToDelete(shoes: shoes))
    }
    
    func deleteShoesToDelete(shoes:FetchedResults<Shoes>, context: NSManagedObjectContext) -> Void {
        let shoesToDelete = getShoesToDelete(shoes: shoes)
        for shoes in shoesToDelete {
            deleteShoes(shoes: shoes, context: context)
        }
        save(context: context)
    }
    
    func deleteShoesToDelete2(shoes:FetchedResults<Shoes>, context: NSManagedObjectContext) -> Void {
        let shoesToDelete = getShoesToDelete(shoes: shoes)
        for shoes in shoesToDelete {
            deleteShoesWithoutSaving(shoes: shoes, context: context)
        }
        save(context: context)
    }
    
    
    func allSelledShoes(shoes:FetchedResults<Shoes>) -> [Shoes] {
        var selledShoes: [Shoes]  = []
        for shoe in shoes {
            if shoe.sellvalue > 0{
                selledShoes.append(shoe)
            }
        }
        return selledShoes
    }
    
    func selledShoesNumber(shoes:FetchedResults<Shoes>) -> Int {
        return lengthArray(a: allSelledShoes(shoes: shoes))
    }
    
    func allUnsoldShoes(shoes:FetchedResults<Shoes>) -> [Shoes] {
        //All unsold shoes and not in Recently Deleted state
        var unsoldShoes: [Shoes] = []
        for shoe in shoes {
            if shoe.sellvalue <= 0  && !shoe.isInDeletingRecentlyState{
                unsoldShoes.append(shoe)
            }
        }
        return unsoldShoes
    }
    
    func unsoldShoesNumber(shoes:FetchedResults<Shoes>) -> Int {
        return lengthArray(a: allUnsoldShoes(shoes: shoes))
    }
    
    
    
    //MARK: Apparel funtions
    
    func addApparel(name: String,
                    brand: String,
                    size: String,
                    buyvalue: Double,
                    imageData: Data,
                    sellestimatedvalue: Double,
                    context: NSManagedObjectContext ) -> Void {
        let apparel = Apparel(context: context)
        apparel.id = UUID()
        apparel.buydate = Date()
        apparel.brand = brand
        apparel.name = name
        apparel.size = size
        apparel.image = imageData
        apparel.buyvalue = buyvalue
        apparel.sellestimatedvalue = sellestimatedvalue
        
        save(context: context)

        
        
    }
    
    func editApparel(apparel: Apparel,
                     name: String,
                     brand:String,
                     size: String,
                     buyvalue: Double,
                     sellestimatedvalue: Double,
                     context: NSManagedObjectContext) -> Void {
        apparel.brand = brand
        apparel.name = name
        apparel.size = size
        apparel.buyvalue = buyvalue
        apparel.sellestimatedvalue = sellestimatedvalue
        
        save(context: context)
        
    }
    
    func sellApparel(apparel: Apparel,
                     sellvalue: Double,
                     sellwebsite: String,
                     context: NSManagedObjectContext) -> Void {
        apparel.selldate = Date()
        apparel.sellvalue = sellvalue
        apparel.sellwebsite = sellwebsite
        
        save(context: context)
    }
    
    func editSellApparel(apparel: Apparel,
                         newsellvalue: Double,
                         newsellwebsite: String,
                         newselldate: Date,
                         context: NSManagedObjectContext) -> Void {
        apparel.selldate = newselldate
        apparel.sellvalue = newsellvalue
        apparel.sellwebsite = newsellwebsite
        
        save(context: context)
    }
    
    func createAndSaveDeposit(name: String,  context: NSManagedObjectContext) -> Deposit {
        let deposit = Deposit(context: context)
        deposit.id = UUID()
        deposit.name = name
        
        save(context: context)
        
        return deposit
    }
    
    func saveDeposit(name: String, context: NSManagedObjectContext) -> Void {
        let deposit = Deposit(context: context)
        deposit.id = UUID()
        deposit.name = name
        save(context: context)
    }
    
    
    
    
    
    //MARK: 2024
    
    func isShoesValidFromConditions(_ shoes: Shoes, from conditions: [(Shoes) -> Bool]) -> Bool {
        for condition in conditions {
            if !condition(shoes) {
                return false
            }
        }
        return true
    }
    
    let CONDITIONS: [(Shoes) -> Bool] = [
        { $0.sellvalue == 0 },
        { $0.isInDeletingRecentlyState == false}
    ]
    
    func getAllValidShoes(shoes: FetchedResults<Shoes>) -> [Shoes] {
        var validShoes: [Shoes] = []
        for shoe in shoes {
            if isShoesValidFromConditions(shoe, from: CONDITIONS) {
                validShoes.append(shoe)
            }
        }
        return validShoes
    }
    
    func getAllShoesSize(shoes: FetchedResults<Shoes>) -> [Double] {
        var out: [Double] = []
        for shoe in shoes{
            if shoe.sellvalue == 0  {
                out.append(shoe.size)
            }
        }
        return out.set() // Array(Set(out))
    }
    
    func packShoesBySize(shoes:FetchedResults<Shoes>, by size: String) -> [UUID] {
        var out: [UUID] = []
        for shoe in shoes{
            if shoe.sellvalue == 0 && String(shoe.size) == size {
                out.append(shoe.id!)
            }
        }
        return out
    }
    
    func packShoesByBrand(shoes: FetchedResults<Shoes>, by brand:String) -> [UUID] {
        var out: [UUID] = []
        for shoe in shoes{
            if shoe.sellvalue == 0 && shoe.brand! == brand{
                out.append(shoe.id!)
            }
        }
        return out
    }
    
    func shoesNumberByBrand(shoes: FetchedResults<Shoes>, by brand:String) -> Int {
        let packShoes = packShoesByBrand(shoes: shoes, by: brand)
        return lengthArray(a: packShoes)
    }
    
    func shoesNumberBySize(shoes: FetchedResults<Shoes>, by size: String) -> Int {
        let packShoes = packShoesBySize(shoes: shoes, by: size)
        return lengthArray(a: packShoes)
    }
    
    
    func totalShoes(shoes:FetchedResults<Shoes>) -> Int {
        var number:Int = 0
        for shoe in shoes {
            if shoe.sellvalue == 0 && !shoe.isInDeletingRecentlyState{
                number += 1
            }
        }
        return number
    }
    
    func totalShoesPrices(shoes:FetchedResults<Shoes>) -> String{
        var price: Double = 0
        for shoe in shoes  {
            if shoe.sellvalue == 0 && !shoe.isInDeletingRecentlyState{
                price += Double(shoe.priceStr!)!
            }
        }
        return String(round(price * 100)/100)
    }
    
    func totalResellPrices(shoes:FetchedResults<Shoes>) -> String{
        var resellPrice: Double = 0
        for shoe in shoes{
            if shoe.sellvalue == 0 {
                resellPrice += Double(shoe.ressellPrice!)!
            }
        }
        return String(round(resellPrice * 100)/100)
    }
    
    func totalShoesEstimatedBenefits(shoes:FetchedResults<Shoes>) -> Double {
        var benefit: Double = 0
        for shoe in shoes {
            if shoe.sellvalue == 0 {
                let shoePrice = Double(shoe.priceStr!)!
                let shoeResellPrice = Double(shoe.ressellPrice!)!
                let shoeBenefit = shoeResellPrice - shoePrice
                benefit += shoeBenefit
            }
        }
        return benefit
    }
    
    func totalShoesRealBenefits(shoes:FetchedResults<Shoes>) -> Double {
        var benefit : Double = 0
        for shoe in shoes{
            if shoe.sellvalue != 0{
                let itemPrice = Double(shoe.priceStr!)!
                let itemBenefit = shoe.sellvalue - itemPrice
                benefit += itemBenefit
            }
            
        }
        return benefit
    }
    
    func totalApparels(apparels:FetchedResults<Apparel>) -> Int {
        var number: Int = 0
        for apparel in apparels{
            if apparel.sellvalue == 0 {
                number += 1
            }
        }
        return number
    }
    
    func totalApparelPrices(apparels: FetchedResults<Apparel>) -> String {
        var price: Double = 0
        for apparel in apparels {
            if apparel.sellvalue == 0 {
                price += apparel.buyvalue
            }
        }
        return String(price)
    }
    
    func totalStockPrices(apparels: FetchedResults<Apparel>, shoes:FetchedResults<Shoes>) -> Double {
        let price = Double(totalShoesPrices(shoes: shoes))! + Double(totalApparelPrices(apparels: apparels))!
        return price
    }
    
    func totalApparelEstimatedBenefits(apparels: FetchedResults<Apparel>) -> Double {
        var benefit: Double = 0
        for apparel in apparels {
            if apparel.sellvalue == 0 {
                let apparelBenefit =  apparel.sellestimatedvalue - apparel.buyvalue
                benefit += apparelBenefit
            }
        }
        return benefit
    }
    
    
    
    func totalEstimatedBenefit(shoes:FetchedResults<Shoes>, apparels:FetchedResults<Apparel>) -> Double {
        return totalShoesEstimatedBenefits(shoes: shoes) + totalApparelEstimatedBenefits(apparels: apparels)
    }
    
    func getShoesSaleNumber(shoes:FetchedResults<Shoes>) -> Int { //aka nbsale()
        var out: Int = 0
        for shoe in shoes {
            if shoe.sellvalue != 0 {
                out += 1
            }
        }
        return out
    }
    
    func getApparelsSaleNumber(apparels: FetchedResults<Apparel>) -> Int {
        var out: Int = 0
        for apparel in apparels{
            if apparel.sellvalue != 0 {
                out += 1
            }
        }
        return out
    }
    
    func getAllSaleNumber(shoes: FetchedResults<Shoes>, apparels: FetchedResults<Apparel>) -> Int {
        return getShoesSaleNumber(shoes: shoes) + getApparelsSaleNumber(apparels: apparels)
    }
    
    
    
    
    
    func getWebsiteFromShoes(from shoe: Shoes)-> String {
        if shoe.sellwebsite != nil {
            return String(shoe.sellwebsite!)
        } else {
            return "Non renseigné"
        }
    }
    
    func getImageForShoes(for shoe:Shoes) -> UIImage {
        if UIImage(data: shoe.imageShoes!) != nil {
            return UIImage(data: shoe.imageShoes!)!
        }
        else {
            return UIImage(systemName: "icloud.slash")!
        }
    }
    
    func getDate(date: Date) -> Text {
        return Text(date, style: .date)
    }
    
    func getWebsiteFromApparel(from apparel: Apparel)-> String {
        if apparel.sellwebsite != nil {
            return String(apparel.sellwebsite!)
        } else {
            return "Non renseigné"
        }
    }
    
    func getCurrentYear() -> Int {
        let currentDate = Date()
        let calendar  = Calendar.current
        let year = calendar.component(.year, from: currentDate)
        return year
    }
    
    
    //MARK: Sales
    
    func getShoesSaleYear(shoe:Shoes) -> Int {
        if shoe.selldate != nil {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: shoe.selldate!)
            return year
        }
        return -1
    }
    
    func getApparelSaleYear(apparel:Apparel) -> Int {
        if apparel.selldate != nil {
            let calendar = Calendar.current
            let year = calendar.component(.year, from: apparel.selldate!)
            return year
        }
        return -1
    }
    
    func getAllSoldShoes(shoes:FetchedResults<Shoes>) -> [Shoes] {
        var soldShoes: [Shoes] = []
        for shoe in shoes {
            if shoe.sellvalue > 0 {
                soldShoes.append(shoe)
            }
        }
        return soldShoes
    }
    
    func getAllSoldApparel(apparels:FetchedResults<Apparel>) -> [Apparel] {
        var soldApparels: [Apparel] = []
        for apparel in apparels {
            if apparel.sellvalue > 0 {
                soldApparels.append(apparel)
            }
        }
        return soldApparels
    }

    func getAllShoesSalesYear(shoes:FetchedResults<Shoes>) -> [Int] {
        var years: [Int] = []
        let soldShoes = getAllSoldShoes(shoes: shoes)
        
        for soldShoe in soldShoes {
            years.append(getShoesSaleYear(shoe: soldShoe))
        }
        
        return years.set()
    }
    
    func getAllApparelsSalesYear(apparels:FetchedResults<Apparel>) -> [Int] {
        var years: [Int] = []
        let soldApparels = getAllSoldApparel(apparels: apparels)
        for soldApparel in soldApparels {
            years.append(getApparelSaleYear(apparel: soldApparel))
        }
        return Array(Set(years))
    }
    
    func getAllSalesYear(shoes: FetchedResults<Shoes>, apparels:FetchedResults<Apparel>) -> [Int] { //need to reverse
        return twoArrayUnion(a1: getAllShoesSalesYear(shoes: shoes), a2: getAllApparelsSalesYear(apparels: apparels)).quicksort().reversed()
    }
    
    func packSoldShoesBySaleYear(shoes:FetchedResults<Shoes>, by year: Int) -> [Shoes] {
        var soldShoesByYear: [Shoes] = []
        
        let soldShoes = getAllSoldShoes(shoes: shoes)
        for soldShoe in soldShoes{
            let saleYear = getShoesSaleYear(shoe: soldShoe)
            if saleYear == year {
                soldShoesByYear.append(soldShoe)
            }
        }
        return soldShoesByYear
    }
    
    func packSoldApparelsBySaleYear(apparels:FetchedResults<Apparel>, by year:Int) -> [Apparel] {
        var soldApparelsByYear: [Apparel] = []
        let soldApparels = getAllSoldApparel(apparels: apparels)
        for soldApparel in soldApparels {
            let saleYear = getApparelSaleYear(apparel: soldApparel)
            if saleYear == year {
                soldApparelsByYear.append(soldApparel)
            }
        }
        return soldApparelsByYear
    }
    
    
    
    //MARK: Benefit
    func getColorForBenefit(for benefit: Double) -> Color {
        if benefit > 0 {
            return Color.green
        } else {
            return Color.red
        }
    }
    
    func getShoeBenefit(shoes:Shoes) -> Double {
        let a = Double(shoes.priceStr!)!
        let b = shoes.sellvalue
        return b - a
    }
    
    func getApparelBenefit(apparel: Apparel) -> Double {
        let a = apparel.buyvalue
        let b = apparel.sellvalue
        return b - a
    }
    
    func totalApparelRealBenefit(apparels:FetchedResults<Apparel>) -> Double {
        var benefit: Double = 0
        for apparel in apparels {
            if apparel.sellvalue == 0 {
                let apparelBenefit = apparel.sellvalue - apparel.buyvalue
                benefit += apparelBenefit
            }
        }
        return benefit
    }
    
    func totalRealBenefit(shoes:FetchedResults<Shoes>, apparels: FetchedResults<Apparel>) -> Double {
        return totalShoesRealBenefits(shoes: shoes) + totalApparelRealBenefit(apparels: apparels)
    }
    
    func getSoldShoesRealBenefitByYear(shoes:FetchedResults<Shoes>, by year: Int) -> Double {
        var realBenefit: Double = 0
        let soldShoesByYear = packSoldShoesBySaleYear(shoes: shoes, by: year)
        
        for soldShoe in soldShoesByYear {
            let benefit = getShoeBenefit(shoes: soldShoe)
            realBenefit += benefit
        }
        return realBenefit
    }
    
    func getSoldApparelsRealBenefitByYear(apparels:FetchedResults<Apparel>, by year:Int) -> Double {
        var realBenefit: Double = 0
        let soldApparelsByYear = packSoldApparelsBySaleYear(apparels: apparels, by: year)
        for soldApparel in soldApparelsByYear {
            let benefit = getApparelBenefit(apparel: soldApparel)
            realBenefit += benefit
        }
        return realBenefit
    }
    
    func getRealBenefitByYear(shoes:FetchedResults<Shoes>, apparels:FetchedResults<Apparel>, by year:Int) -> Double {
        return getSoldShoesRealBenefitByYear(shoes: shoes, by: year) + getSoldApparelsRealBenefitByYear(apparels: apparels, by: year)
    }
    
    func getShoesRealBenefitByMonthAndYear(shoes:FetchedResults<Shoes>, month: String, by year: Int) -> Double {
        var monthBenefit: Double = 0
        let soldShoesMonthAndYear = packSoldShoesBySaleMonthAndYear(shoes: shoes, month: month, by: year)
        for soldShoe in soldShoesMonthAndYear {
            let benefit = getShoeBenefit(shoes: soldShoe)
            monthBenefit += benefit
        }
        return monthBenefit
    }
    
    func getApparelsRealBenefitByMonthAndYear(apparels:FetchedResults<Apparel>, month: String, by year: Int) -> Double {
        var monthBenefit: Double = 0
        let soldApparelsMonthAndYear = packSoldApparelsBySaleMonthAndYear(apparels: apparels, month: month, by: year)
        for soldApparel in soldApparelsMonthAndYear{
            let benefit = getApparelBenefit(apparel: soldApparel)
            monthBenefit += benefit
        }
        return monthBenefit
    }
    
    func getRealBenefitByMonthAndYear(shoes:FetchedResults<Shoes>, apparels:FetchedResults<Apparel>, month:String, by year:Int) -> Double {
        let shoesBenefitMonthAndYear = getShoesRealBenefitByMonthAndYear(shoes: shoes, month: month, by: year)
        let apparelsBenefitMonthAndyear = getApparelsRealBenefitByMonthAndYear(apparels: apparels, month: month, by: year)
        return shoesBenefitMonthAndYear + apparelsBenefitMonthAndyear
    }
    
    
    //MARK: Turnover
    
    func getShoesTurnover(shoes:FetchedResults<Shoes>) -> Double {
        var out: Double = 0
        for shoe in shoes {
            if shoe.sellvalue > 0 {
                out += shoe.sellvalue
            }
        }
        return out
    }
    
    func getApparelTurnover(apparels:FetchedResults<Apparel>) -> Double {
        var out: Double = 0
        for apparel in apparels {
            if apparel.sellvalue > 0 {
                out += apparel.sellvalue
            }
        }
        return out
    }
    
    func getTotalTurnover(shoes:FetchedResults<Shoes>, apparels: FetchedResults<Apparel>) -> Double {
        return getShoesTurnover(shoes: shoes) + getApparelTurnover(apparels: apparels)
    }
    
    func getSoldShoesTurnoverByYear(shoes:FetchedResults<Shoes>, by year: Int) -> Double {
        var turnover: Double = 0
        let soldShoesByYear = packSoldShoesBySaleYear(shoes: shoes, by: year)
        for soldShoe in soldShoesByYear {
            turnover += soldShoe.sellvalue
        }
        return turnover
    }
    
    func getSoldApparelsTurnoverByYear(apparels: FetchedResults<Apparel>, by year:Int) -> Double {
        var turnover: Double = 0
        let soldApparelsByYear = packSoldApparelsBySaleYear(apparels: apparels, by: year)
        for soldApparel in soldApparelsByYear {
            turnover += soldApparel.sellvalue
        }
        return turnover
    }
    
    func getTurnoverByYear(shoes:FetchedResults<Shoes>, apparels:FetchedResults<Apparel>, by year:Int) -> Double {
        return getSoldShoesTurnoverByYear(shoes: shoes, by: year) + getSoldApparelsTurnoverByYear(apparels: apparels, by: year)
    }
    
    func getShoesTurnoverByMonthAndYear(shoes:FetchedResults<Shoes>, month: String, by year: Int) -> Double {
        let soldShoesMonthAndYear = packSoldShoesBySaleMonthAndYear(shoes: shoes, month: month, by: year)
        var monthTurnover: Double = 0
        for soldShoe in soldShoesMonthAndYear {
            monthTurnover += soldShoe.sellvalue
        }
        return monthTurnover
    }
    
    func getApparelsTurnoverByMonthAndYear(apparels:FetchedResults<Apparel>, month: String, by year: Int) -> Double {
        let soldApparelsMonthAndYear = packSoldApparelsBySaleMonthAndYear(apparels: apparels, month: month, by: year)
        var monthTurnover: Double = 0
        for soldApparel in soldApparelsMonthAndYear {
            monthTurnover += soldApparel.sellvalue
        }
        return monthTurnover
    }
    
    func getTurnoverByMonthAndYear(shoes:FetchedResults<Shoes>, apparels:FetchedResults<Apparel>, month:String, by year:Int) -> Double {
        let apparelTurnover = getApparelsTurnoverByMonthAndYear(apparels: apparels, month: month, by: year)
        let shoesTurnover = getShoesTurnoverByMonthAndYear(shoes: shoes, month: month, by: year)
        return shoesTurnover + apparelTurnover
    }
    
    
    //MARK: Month
    
    func getShoesSalesMonthByYear(shoes:FetchedResults<Shoes>, by year: Int) -> [String] {
        let soldShoesYear = packSoldShoesBySaleYear(shoes: shoes, by: year)
        var saleMonths: [String] = []
        for soldShoe in soldShoesYear {
            let saleMonth:String = getOnlyMonthFromSelldate(from:soldShoe.selldate!)
            saleMonths.append(saleMonth)
        }
        return saleMonths.set()
    }
    
    func getApparelsSalesMonthByYear(apparels:FetchedResults<Apparel>, by year: Int) -> [String] {
        let soldApparelsYear = packSoldApparelsBySaleYear(apparels: apparels, by: year)
        var saleMonths: [String] = []
        for soldApparel in soldApparelsYear {
            let saleMonth:String = getOnlyMonthFromSelldate(from: soldApparel.selldate!)
            saleMonths.append(saleMonth)
        }
        return saleMonths.set()
    }
    
    func getSalesMonthByYear(shoes:FetchedResults<Shoes>, apparels:FetchedResults<Apparel>, by year:Int) -> [String] {
        let apparelsSaleMonths = getApparelsSalesMonthByYear(apparels: apparels, by: year)
        let shoesSaleMonths = getShoesSalesMonthByYear(shoes: shoes, by: year)
        let union = twoArrayUnion(a1: apparelsSaleMonths, a2: shoesSaleMonths)
        return union.sortMonths().reversed()
    }
    
    func packSoldShoesBySaleMonthAndYear(shoes:FetchedResults<Shoes>, month: String, by year: Int) -> [Shoes] {
        let soldShoesYear = packSoldShoesBySaleYear(shoes: shoes, by: year)
        var packSoldShoesMonthYear: [Shoes] = []
        for soldShoe in soldShoesYear {
            let saleShoesMonth = getOnlyMonthFromSelldate(from: soldShoe.selldate!)
            if saleShoesMonth == month{
                packSoldShoesMonthYear.append(soldShoe)
            }
        }
        return packSoldShoesMonthYear.set()
    }
    
    func packSoldApparelsBySaleMonthAndYear(apparels:FetchedResults<Apparel>, month: String, by year: Int) -> [Apparel] {
        let soldApparelsYear = packSoldApparelsBySaleYear(apparels: apparels, by: year)
        var packSoldApparelsMonthYear: [Apparel] = []
        for soldApparel in soldApparelsYear {
            let saleApparelMonth = getOnlyMonthFromSelldate(from: soldApparel.selldate!)
            if saleApparelMonth == month{
                packSoldApparelsMonthYear.append(soldApparel)
            }
        }
        return packSoldApparelsMonthYear
    }

    
    
    
    //MARK: Deposit
    
    func getAllDepositId(deposits:FetchedResults<Deposit>) -> [UUID] {
        var ids: [UUID] = []
        for deposit in deposits{
            ids.append(deposit.id!)
        }
        return ids
    }
    
    func getAllDepositsName(deposits:FetchedResults<Apparel>) -> [String] {
        var names: [String] = []
        for deposit in deposits {
            names.append(deposit.name!)
        }
        return names.set()
    }
    


    
    func addDeposit(name: String,
                    context : NSManagedObjectContext) {
        let deposit = Deposit(context: context)
        deposit.id = UUID()
        deposit.name = name
        
        save(context: context)
    }
    
    func createAndReturnDeposit(name:String, context: NSManagedObjectContext) -> Deposit {
        let deposit = Deposit(context: context)
        deposit.id = UUID()
        deposit.name = name
        save(context: context)
        return deposit
    }
    
    func createAndReturnDepositWithoutSaving(name:String, context: NSManagedObjectContext) -> Deposit {
        let deposit = Deposit(context: context)
        deposit.id = UUID()
        deposit.name = name
        return deposit
    }
    

    
    
    
    
    //MARK: Prenium 
    
    func addFastShoes(shoes: Shoes,
                      size: Double,
                      priceStr: String?,
                      ressellPrice: String?,
                      context : NSManagedObjectContext) {
        let newShoes = Shoes(context: context)
        newShoes.id = UUID()
        newShoes.name = shoes.name
        newShoes.jour = Date()
        newShoes.brand = shoes.brand
        newShoes.price = shoes.price
        newShoes.size = size
        newShoes.priceStr = priceStr ?? shoes.priceStr
        newShoes.ressellPrice = ressellPrice ?? shoes.ressellPrice
        newShoes.stockxStyle = shoes.stockxStyle
        newShoes.imageShoes = shoes.imageShoes
        
        
        save(context: context)
    }
    func addFastShoes2(shoes: Shoes,
                      size: Double,
                      priceStr: String?,
                      ressellPrice: String?,
                      deposit: Deposit?,
                      context : NSManagedObjectContext) {
        let newShoes = Shoes(context: context)
        newShoes.id = UUID()
        newShoes.name = shoes.name
        newShoes.jour = Date()
        newShoes.brand = shoes.brand
        newShoes.price = shoes.price
        newShoes.size = size
        newShoes.priceStr = priceStr ?? shoes.priceStr
        newShoes.ressellPrice = ressellPrice ?? shoes.ressellPrice
        newShoes.stockxStyle = shoes.stockxStyle
        newShoes.imageShoes = shoes.imageShoes
    
        
        save(context: context)
    }
    
    //MARK: ToDo
        // change buydate
        //change all function with datacontroller ones
        // deal with CONDITIONS
        // monetize !
        //parameter
        //
    
}





