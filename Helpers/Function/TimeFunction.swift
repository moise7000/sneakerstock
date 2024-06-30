//
//  TimeFormatting.swift
//  26123
//
//  Created by ewan decima on 26/12/2022.
//

import Foundation
import SwiftUI



func calcTimeSInce(date: Date) -> String {
    let minutes = Int(-date.timeIntervalSinceNow)/60
    let hours = minutes/60
    let days = hours/24
    
    if minutes < 120{
        return "\(minutes) minutes ago"
    } else if minutes >= 120 && hours < 48 {
        return "\(hours) hours ago"
    } else {
        return "\(days) days ago"
    }
}

func compareTwoDates(date1 : Date, date2 : Date) -> Bool {
    let a = Int(-date1.timeIntervalSinceNow)
    let b = Int(-date1.timeIntervalSinceNow)
    
    return a > b
}

func minOfTwoDates(date1:Date, date2: Date) -> Date {
    if compareTwoDates(date1: date1, date2: date2){
        return date2
    }
    return date1
       
}

func maxOfTwoDates(date1:Date, date2: Date)->Date {
    if compareTwoDates(date1: date1, date2: date2){
        return date1
    }
    return date2
       
}

func isValidToDisplayBool(date: Date, dayNumberIPeriod: Int)->Bool {
    let minuteSinceDate  = -date.timeIntervalSinceNow/60
    let hourSinceDate = minuteSinceDate/60
    let daySinceDate  = Int(hourSinceDate/24)
    
    
    var out: Bool = true
    
    if daySinceDate > dayNumberIPeriod{
        out = false
    }
    
    return out
}

func isValidToDisplay(date: Date) -> Int {
    let minuteSinceDate  = -date.timeIntervalSinceNow/60
    let hourSinceDate = minuteSinceDate/60
    let daySinceDate  = Int(hourSinceDate/24)

    return daySinceDate
}

func getMonthFromDate(date: Date) -> String{
    
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "FR")
    dateFormatter.dateFormat = "MMMM yyyy"
    let monthYearString = dateFormatter.string(from: date)
    
    return monthYearString
    
}

func getOnlyMonthFromSelldate(from selldate: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "FR")
    dateFormatter.dateFormat = "MMMM"
    let monthYearString = dateFormatter.string(from: selldate)
    
    return monthYearString
}

func getMonthFromDateArray(arr:Array<Date>)->Array<String> {
    var out :Array<String> = []
    for date in arr{
        let newElement = getMonthFromDate(date: date)
        out.append(newElement)
    }
    return out 
}

func getDateFromString(dateString: String, format: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.date(from: dateString)!
}

func sortDates( dates: [String]) -> [String] {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMMM yyyy"
    
    let sortedDates = dates.compactMap { dateFormatter.date(from: $0) }
                           .sorted()
                           .compactMap { dateFormatter.string(from: $0) }
    
    return sortedDates
}

func sortArrayDate(arr: Array<Date>)->Array<Date> {
    if arr == []{
        return arr
    }
    let n = lengthArray(a: arr)
    var arrVar = copyArray(a: arr)
    for i in 0 ... n-1 {
        for j in 0 ... n-1{
            if compareTwoDates(date1:arr[j], date2:arr[i]) {
                arrVar[j] = arr[i]
                arrVar[i] = arr[j]
            }
        }
    }
    return arr
}

func dayNumberSinceNow(date:Date) -> Int {
    let calendar = Calendar.current
    let now =  Date()
    
    let composants = calendar.dateComponents([.day], from: now, to: date)
        if let jours = composants.day {
            return jours
        } else {
            return 0
        }
    
}

func displaydate(date: Date) -> any View {
    return Text(date, style: .date)
}
