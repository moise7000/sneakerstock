//
//  DepositFunction.swift
//  26123
//
//  Created by ewan decima on 24/11/2023.
//

import Foundation
import CoreData
import SwiftUI


func inputValidityDepositName(_ name:String, deposits:FetchedResults<Deposit>) -> Bool {
    for deposit in deposits {
        if deposit.name == name{
            return false
        }
    }
    return true
}

func getAllDepositName(deposits: FetchedResults<Deposit>) -> Array<String> {
    var out: Array<String> = []
    
    for deposit in deposits{
        out.append(deposit.name!)
    }
    return out 
}


func depositAlreadyExist(_ newDepositName: String, deposits: FetchedResults<Deposit>) -> Bool {
    for x in deposits{
        if x.name == newDepositName{
            return true
        }
    }
    return false
}


func getDepositByUUID(id: UUID, deposits: FetchedResults<Deposit>) -> Deposit?{
    for deposit in deposits{
        if deposit.id == id {
            return deposit
        }
    }
    return nil
}


func getDepositByName(_ nameDeposit: String, deposits: FetchedResults<Deposit>) -> Deposit?{
    for deposit in deposits{
        if deposit.name == nameDeposit{
            return deposit
        }
    }
    return nil
}


func depositForPicker(_ deposits: FetchedResults<Deposit>) -> Array<String>{
    var out: Array<String> = ["Séléctionner un dépot"]
    for deposit in deposits{
        out.append(deposit.name!)
    }
    out.append("Nouveau dépot")
    return out
}
