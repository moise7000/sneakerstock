//
//  InfoFunction.swift
//  26123
//
//  Created by ewan decima on 06/09/2023.
//

import Foundation
import SwiftSoup


func scrapeNameFromURL(urlString: String, completion: @escaping (String?) -> Void) {
    // Vérifier si l'URL est valide
    guard let url = URL(string: urlString) else {
        print("URL invalide.")
        completion(nil)
        return
    }

    // Créer une URLSession
    let session = URLSession.shared

    // Créer une tâche de téléchargement de données
    let task = session.dataTask(with: url) { data, response, error in
        // Vérifier s'il y a des erreurs
        if let error = error {
            print("Une erreur s'est produite lors du téléchargement : \(error)")
            completion(nil)
            return
        }

        // Vérifier s'il y a des données reçues
        guard let data = data else {
            print("Aucune donnée reçue.")
            completion(nil)
            return
        }

        do {
            // Convertir les données en une chaîne de caractères
            let html = String(data: data, encoding: .utf8)

            // Charger le contenu dans SwiftSoup
            let doc: Document = try SwiftSoup.parse(html ?? "")

            // Utiliser des sélecteurs CSS pour extraire le texte de la classe "chakra-text css-3lpefb"
            let elementsWithClass: Elements = try doc.select(".chakra-text.css-3lpefb")
            
            if let text = try? elementsWithClass.text(), !text.isEmpty {
                completion(text)
            } else {
                print("Aucun texte trouvé dans la classe 'chakra-text css-3lpefb' sur le site.")
                completion(nil)
            }

        } catch {
            print("Une erreur s'est produite lors du web scraping : \(error)")
            completion(nil)
        }
    }

    // Lancer la tâche de téléchargement
    task.resume()
}
