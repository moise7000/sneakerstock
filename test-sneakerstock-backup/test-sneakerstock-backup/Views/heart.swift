//
//  test.swift
//  26123
//
//  Created by ewan decima on 31/01/2023.
//

import SwiftUI

struct heart: View {
    var body: some View {
        ScrollView {
                   LazyVGrid(columns: [.init(), .init(),.init()]) {
                       ForEach(0..<10) { _ in
                           GroupBox(
                               label: Label("Heart Rate", systemImage: "heart.fill")
                                   .foregroundColor(.red)
                           ) {
                               Text("Your hear rate is 90 BPM.")
                           }.groupBoxStyle(plainGroupBoxStyle())
                       }
                   }.padding()
               }
    }
}


struct plainGroupBoxStyle: GroupBoxStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack(alignment: .leading) {
            configuration.label
            configuration.content
        }
        .padding()
        .background(Color(.systemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
    }
}

