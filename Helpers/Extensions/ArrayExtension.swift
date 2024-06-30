//
//  ArrayExtention.swift
//  26123
//
//  Created by ewan decima on 16/01/2024.
//

import Foundation

extension Array where Element: Hashable  {
    func set() -> [Element]{
        return Array(Set(self))
    }
}

extension Array where Element: Comparable {
    func quicksort() -> [Element] {
        var result = self
        quickSort(&result)
        return result
    }
    
    private func quickSort(_ array: inout [Element]) {
        guard array.count > 1 else {
            return
        }
        quickSortHelper(&array, low: 0, high: array.count - 1)
    }
    
    private func quickSortHelper(_ array: inout [Element], low: Int, high: Int) {
        if low < high {
            let pivotIndex = partition(&array, low: low, high: high)
            quickSortHelper(&array, low: low, high: pivotIndex - 1)
            quickSortHelper(&array, low: pivotIndex + 1, high: high)
        }
    }
    
    private func partition(_ array: inout [Element], low: Int, high: Int) -> Int {
        let pivot = array[high]
        var i = low - 1
        
        for j in low..<high {
            if array[j] <= pivot {
                i += 1
                array.swapAt(i, j)
            }
        }
        
        array.swapAt(i + 1, high)
        return i + 1
    }
}

extension Array where Element == String {
    func sortMonths() -> [String] {
        return sortMonths(self)
    }
    private func sortMonths(_ months: [String]) -> [String] {
        return months.sorted { (month1, month2) -> Bool in
            let monthOrder: [String] = ["janvier", "février", "mars", "avril", "mai", "juin", "juillet", "août", "septembre", "octobre", "novembre", "décembre"]
            
            guard let index1 = monthOrder.firstIndex(of: month1),
                  let index2 = monthOrder.firstIndex(of: month2) else {
                return month1 < month2
            }
            
            return index1 < index2
        }
    }
}






