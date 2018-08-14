//
//  ProductHandler.swift
//  Avoid
//
//  Created by Matheus Garcia on 14/08/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

class ProductHandler: NSObject {

    func verifyProduct(barcode: String, completion: @escaping (Bool) -> Void) {

        let productMannager = ProductController()
        productMannager.findProductOnDatabse(productBarcode: barcode) { (product) in

            let ingredientsMannager = IngredientsController()
            ingredientsMannager.findIngredients(fromProduct: product, completion: { (ingredients) in

                // Here you have all the ingredients from the product
            })
        }
    }
}
