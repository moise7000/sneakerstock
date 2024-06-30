//
//  TextRectangle.swift
//  26123
//
//  Created by ewan decima on 27/08/2023.
//

import SwiftUI

struct TextRectangle: View {
    
    var message: String
    
    var body: some View {
        Text(message)
            .padding()
            .background{
                RoundedRectangle(cornerRadius: 10, style:.continuous)
                    .fill(.white.shadow(.drop(radius: 1.5)))
                
            }
    }
}

