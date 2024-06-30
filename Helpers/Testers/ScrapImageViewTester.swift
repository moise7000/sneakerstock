//
//  ScrapImageViewTester.swift
//  26123
//
//  Created by ewan decima on 30/07/2023.
//

import SwiftUI

struct ScrapImageViewTester: View {
    
    
    
    @State private var images: [UIImage] = []
    
    var body: some View {
        VStack {
            Button("Télécharger et Afficher les Images") {
                let id = "fd8776-800"
                let urlString = "https://stockx.com/fr-fr/search?s=\(id)"
                
                
                // Remplacez cette URL par celle que vous souhaitez scraper
                scrapeNameFromURL(urlString: urlString, completion: { text in
                    if let text = text {
                        print("Texte extrait de la classe 'nomModel': \(text)")
                    } else {
                        print("Aucun texte trouvé dans la classe 'nomModel'.")
                    }
                })

            }
            
            
           
        }
    }
    
    

}
