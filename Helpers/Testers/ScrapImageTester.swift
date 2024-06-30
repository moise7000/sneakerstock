import Foundation
import SwiftSoup
import Swift
import SwiftUI


import Foundation
import SwiftSoup

func scrapeImageDataFromURL(urlString: String, completion: @escaping (Data?) -> Void) {
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

            // Utiliser des sélecteurs CSS pour extraire la première image (balise <img>)
            let imgElements: Elements = try doc.select("img")
            if let firstImgElement = imgElements.first, let src = try? firstImgElement.attr("src"), !src.isEmpty {
                // Télécharger et retourner les données de l'image
                downloadImageData(urlString: src, completion: completion)
            } else {
                print("Aucune image trouvée sur le site.")
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

// Fonction pour télécharger les données de l'image
func downloadImageData(urlString: String, completion: @escaping (Data?) -> Void) {
    // Vérifier si l'URL de l'image est valide
    guard let imageURL = URL(string: urlString) else {
        print("URL de l'image invalide.")
        completion(nil)
        return
    }

    // Créer une URLSession
    let session = URLSession.shared

    // Créer une tâche de téléchargement de données
    let task = session.dataTask(with: imageURL) { data, response, error in
        // Vérifier s'il y a des erreurs
        if let error = error {
            print("Une erreur s'est produite lors du téléchargement de l'image : \(error)")
            completion(nil)
            return
        }

        // Vérifier s'il y a des données reçues
        guard let data = data else {
            print("Aucune donnée reçue pour l'image.")
            completion(nil)
            return
        }

        // Renvoyer les données de l'image
        completion(data)
    }

    // Lancer la tâche de téléchargement
    task.resume()
}

// Exemple d'utilisation
let urlString = "https://www.example.com" // Remplacez cette URL par celle que vous souhaitez scraper
