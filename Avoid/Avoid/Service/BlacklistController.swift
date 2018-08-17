//
//  BlacklistController.swift
//  Avoid
//
//  Created by Matheus Garcia on 15/08/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

class BlacklistController {

    func saveBlacklist(add: [Ingredient], remove: [BlacklistIngredient], completion: @escaping (Bool) -> Void) {

        let databaseConnection = CloudKitConnectivity()
        let savingResult = databaseConnection.saveBlacklist(add: add, remove: remove)
        completion(savingResult)
    }

    func loadBlacklist(completion: @escaping ([BlacklistIngredient]) -> Void) {

        let databaseConnection = CloudKitConnectivity()
        let result = databaseConnection.loadBlacklist { (record) in

            let parser = ParseManager()
            let ingredients = parser.parseIngredientsId(data: record)

            completion(ingredients)
        }

        if !result {
            print("Error loading blacklist")
        }
    }
}
