//
//  ChartBar.swift
//  26123
//
//  Created by ewan decima on 08/03/2023.
//

import SwiftUI
import Charts


struct ChartBarMonth: View {
    
    
    
    var myAbs: [Date]
    var color: Color
    var myFunc: (Date)->Double
    var width : CGFloat
    var height : CGFloat
    
    var body: some View {
        Chart{
            ForEach(myAbs, id:\.self) {
                item in
                BarMark(x: .value("Date", item, unit:.day),
                            y: .value("Retail", myFunc(item))
                    )
                
            }
        }
        
        .frame(width: width, height: height)
        .foregroundStyle(LinearGradient(gradient: Gradient(colors: [ .red, .pink]), startPoint: .leading, endPoint: .trailing))
        .chartXAxis{
            AxisMarks(values: .stride(by:.month))
        }

    }
}

