
import SwiftSoup
import SwiftUI

enum LoadImageError: Error {
    case invalidURL
    case networkError(Error)
    case parsingError(Error)
}

func loadImage(productID: String, completion: @escaping (Result<UIImage, LoadImageError>) -> Void) {
    let url = "https://stockx.com/search?s=\(productID)"
    let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
        if let error = error {
            completion(.failure(.networkError(error)))
            return
        }
        guard let data = data else {
            completion(.failure(.networkError(NSError(domain: "Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"]))))
            return
        }
        do {
            // Parsez le code HTML avec SwiftSoup
            let doc = try SwiftSoup.parse(String(data: data, encoding: .utf8)!)
            // Sélectionnez l'élément d'image avec SwiftSoup
            let imageElement = try doc.select("img").first()
            // Extraire l'URL de l'image de l'attribut "src" de l'élément d'image
            let imageURLString = try imageElement?.attr("src")
            // Chargez l'image à partir de l'URL
            guard let imageURL = URL(string: imageURLString!) else {
                completion(.failure(.invalidURL))
                return
            }
            let imageData = try Data(contentsOf: imageURL)
            let image = UIImage(data: imageData)
            completion(.success(image!))
        } catch {
            completion(.failure(.parsingError(error)))
        }
    }
    task.resume()
}

func getImageData(productID: String, completion: @escaping (Result<Data, LoadImageError>) -> Void) {
    let url = "https://stockx.com/search?s=\(productID)"
    let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
        if let error = error {
            completion(.failure(.networkError(error)))
            return
        }
        guard let data = data else {
            completion(.failure(.networkError(NSError(domain: "Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"]))))
            return
        }
        do {
            // Parsez le code HTML avec SwiftSoup
            let doc = try SwiftSoup.parse(String(data: data, encoding: .utf8)!)
            // Sélectionnez l'élément d'image avec SwiftSoup
            let imageElement = try doc.select("img").first()
            // Extraire l'URL de l'image de l'attribut "src" de l'élément d'image
            let imageURLString = try imageElement?.attr("src")
            // Chargez l'image à partir de l'URL
            guard let imageURL = URL(string: imageURLString!) else {
                completion(.failure(.invalidURL))
                return
            }
            let imageData = try Data(contentsOf: imageURL)
            
            completion(.success(imageData))
        } catch {
            completion(.failure(.parsingError(error)))
        }
    }
    task.resume()
}


func getImageFromData(data: Data) -> UIImage{
    if UIImage(data: data) != nil{
        return UIImage(data: data)!
    }
    else{
        return UIImage(systemName: "icloud.slash")!
    }
    
    
}



















func loadImageURL(productID: String, completion: @escaping (Result<URL, LoadImageError>) -> Void) {
    let url = "https://stockx.com/search?s=\(productID)"
    let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
        if let error = error {
            completion(.failure(.networkError(error)))
            return
        }
        guard let data = data else {
            completion(.failure(.networkError(NSError(domain: "Error", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"]))))
            return
        }
        do {
            // Parsez le code HTML avec SwiftSoup
            let doc = try SwiftSoup.parse(String(data: data, encoding: .utf8)!)
            // Sélectionnez l'élément d'image avec SwiftSoup
            let imageElement = try doc.select("img").first()
            // Extraire l'URL de l'image de l'attribut "src" de l'élément d'image
            let imageURLString = try imageElement?.attr("src")
            // Créez un objet URL à partir de l'URL de l'image
            guard let imageURL = URL(string: imageURLString!) else {
                completion(.failure(.invalidURL))
                return
            }
            // Renvoyez l'URL de l'image à l'aide de la fonction de retour
            completion(.success(imageURL))
        } catch {
            completion(.failure(.parsingError(error)))
        }
    }
    task.resume()
}
