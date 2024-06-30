//
//  StringFunction.swift
//  26123
//
//  Created by ewan decima on 19/11/2023.
//

import Foundation

func inputStringValidity(input: String) -> Bool {
    if input == "" {
        return false
    }
    
    for s in input{
        if s != " " {
            return true
        }
    }
    return false
}


func multipleInputStringValidity(inputArray: Array<String>) -> Bool{
    for input in inputArray{
        if !inputStringValidity(input: input) {
            return false
        }
    }
    return true
}



func setStringForUrl(_ str: String) -> String {
    var out: String = ""
    for s in str {
        if s != " "{
            out.append(s)
        } else {
            out.append("+")
        }
    }
    return out 
}
