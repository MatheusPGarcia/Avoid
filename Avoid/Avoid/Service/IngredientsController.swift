//
//  IngredientsController.swift
//  Avoid
//
//  Created by Matheus Garcia on 13/08/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

class IngredientsController: NSObject {

    func findIngredients(fromProduct product: Product, completion: @escaping ([Ingredient]) -> Void) {

        let databaseConnection = CloudKitConnectivity()
        databaseConnection.fetchIngredients(product: product) { (record) in

            let parser = ParseManager()
            let ingredients = parser.parseIngredients(data: record)

            completion(ingredients)
        }
    }
}
