//
//  CoreData Function.swift
//  26123
//
//  Created by ewan decima on 19/06/2023.
//

import Foundation
import CoreData
import UIKit


import UIKit
import CoreData

func refreshCoreData(context: NSManagedObjectContext) {
    func refreshEntity(entityName: String) {
        // Créez une demande de récupération pour l'entité spécifiée
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            // Récupérez les objets correspondants à la demande de récupération
            let results = try context.fetch(fetchRequest)
            
            for object in results {
                // Actualisez chaque objet en appelant les méthodes appropriées
                context.refresh(object as! NSManagedObject, mergeChanges: true)
            }
            
            // Sauvegardez les changements
            try context.save()
            
            print("CoreData pour l'entité \(entityName) a été actualisé avec succès.")
            
        } catch let error as NSError {
            print("Erreur lors de l'actualisation CoreData pour l'entité \(entityName) : \(error), \(error.userInfo)")
        }
    }
    
    // Appeler la fonction refreshEntity avec le nom de chaque entité que vous souhaitez actualiser
    refreshEntity(entityName: "Shoes")
    refreshEntity(entityName: "Apparel")
    // Ajoutez d'autres appels refreshEntity pour chaque entité supplémentaire
    
    // Vous pouvez également ajouter d'autres actions après l'actualisation de CoreData si nécessaire
    // ...
}

func transformIdIntoString(id: UUID) -> String{
    return String(id.description)
}
