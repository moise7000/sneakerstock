//
//  DoubleFunction.swift
//  26123
//
//  Created by ewan decima on 08/07/2023.
//

import Foundation


let data = [1000: "K",
            1000000: "M"]

func convertDoubleToLisibleString(x: Double)->String{
    if x/1000000 > 1 {
        let out = x/1000000
        let outRounded = round(out * 10) / 10
        return "\(outRounded)M€"

    }
    if x/1000 > 1 {
        let out = x/1000
        let roundedOut = round(out * 10) / 10
        
        return "\(roundedOut)K€"
    }
    
    return "\(x)€"
}
