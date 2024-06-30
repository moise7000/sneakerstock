//
//  RelationFunction .swift
//  26123
//
//  Created by ewan decima on 24/11/2023.
//

import Foundation
import CoreData
import SwiftUI


func getDepositFromShoes(shoes:Shoes, deposits: FetchedResults<Deposit>) -> Deposit? {
    for deposit in deposits{
        if deposit.id == shoes.id{
            return deposit
        }
    }
    return nil
}

func isShoesHaveDeposit(shoes:Shoes, deposits: FetchedResults<Deposit>) -> Bool {
    return getDepositFromShoes(shoes: shoes, deposits: deposits) != nil
    
}
