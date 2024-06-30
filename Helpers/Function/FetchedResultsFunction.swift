//
//  FetchedResultsFunction.swift
//  26123
//
//  Created by ewan decima on 21/11/2023.
//

import Foundation
import CoreData
import SwiftUI

func lengthFetchedResultsDeposit(fetchedResults: FetchedResults<Deposit>) -> Int{
    var out: Int = 0
    for _ in fetchedResults{
        out += 1
    }
    return out
}


func isEmptyFetchedResultsDeposit(fetchedResults: FetchedResults<Deposit>) -> Bool {
    return lengthFetchedResultsDeposit(fetchedResults: fetchedResults) == 0
}

