//
//  ColorExtension.swift
//  26123
//
//  Created by ewan decima on 16/01/2024.
//

import Foundation
import SwiftUI

extension Double {
    func isStPositive() -> Color {
        if self > 0 {
            return .green
        } else {
            return . red
        }
    }
}
