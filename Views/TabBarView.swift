//
//  TabBarView.swift
//  26123
//
//  Created by ewan decima on 28/01/2023.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView{
            myInfoView()
                .tabItem{
                    Image(systemName: "house")
                    Text("Info")
                }
            
            SalesHistory()
                .tabItem{
                    Image(systemName: "books.vertical")
                    Text("Ventes")
                }
            
            myShoesListView()
                .tabItem{
                    Image(systemName: "shoe")
                        
                    Text("Sneakers")
                }
            
            myApparelListView()
                .tabItem{
                    Image(systemName: "tshirt")
                    Text("Apparel")
                }
            
//            ScrapImageViewTester()
//                .tabItem {
//                    Image(systemName: "testtube.2")
//                    Text("Test")
//                }
            
           
           
            
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
