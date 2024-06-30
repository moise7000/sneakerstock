//
//  ArrayFunction.swift
//  26123
//
//  Created by ewan decima on 12/03/2023.
//

import Foundation


func isUUIDArrayUUID(x: UUID, a: Array<UUID>) -> Bool{
    var out = false
    for id in a{
        if x == id{
            out = true
        }
    }
    return out 
}

func isIn<T:Comparable>(x: T, array: [T]) -> Bool{
    for element in array {
        if element == x {
            return true
        }
    }
    return false
}

func lengthArray(a: Array<Any>) -> Int{
    var out = 0
    for _ in a{
        out += 1
    }
    return out
}

func isArrayEmpty(a: Array<Any>) -> Bool{
    return lengthArray(a: a) == 0
}

func getRightIndexOfStringArray(x: String, a: Array<String>) -> Int{
    var out = 0
    for element in a{
        while element != x{
            out += 1
        }
    }
    return out
}


func copyArray(a: Array<Date>)->Array<Date>{
    var out : Array<Date> = []
    for element in a{
        out.append(element)
    }
    return out 
}

func copyArrayShoes(a: Array<Shoes>)->Array<Shoes>{
    var out : Array<Shoes> = []
    for element in a{
        out.append(element)
    }
    return out
}

func xInStringArray(element:String, a : Array<String>) -> Bool{
    for x in a{
        if x == element {
            return true
        }
    }
    return false
}

func setStringArray(a:Array<String>) -> Array<String>{
    var out : Array<String> = []
    
    for element in a{
        if !xInStringArray(element: element, a: out){
            out.append(element)
        }
    }
    return out
    
}

func setArray<T: Comparable>(array: [T]) -> [T]{
    var out: [T] = []
    for element in array {
        if !isIn(x: element, array: array) {
            out.append(element)
        }
    }
    return out
}

func twoArrayUnion<T:Comparable>(a1: [T], a2: [T]) -> [T] {
    
    var out: [T] = a1
    for element in a2 {
        if !isIn(x: element, array: a1) {
            out.append(element)
        }
    }
    return out
}



