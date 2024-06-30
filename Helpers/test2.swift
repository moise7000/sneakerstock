//
//  test2.swift
//  26123
//
//  Created by ewan decima on 31/12/2022.
//

import SwiftUI

struct test2: View {
    
    
    
    var body: some View {
        NavigationLink(destination: myInfoView()) {
            HStack{
                Form{
                    Section {
                        Image("aston")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }
                
            }
        }
        NavigationLink{
            myInfoView()
        } label: {
            Label("STAR", systemImage: "star.fill")
        }.buttonStyle(.bordered)
        
        
        
    }
}

struct test2_Previews: PreviewProvider {
    static var previews: some View {
        test2()
    }
}
