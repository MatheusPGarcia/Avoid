//
//  ProductController.swift
//  Avoid
//
//  Created by Matheus Garcia on 13/08/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation
import CloudKit

class ProductController: NSObject {

    func findProductOnDatabse(productBarcode: String, completion: @escaping (Product) -> Void) {

        let databaseConnection = CloudKitConnectivity()
        databaseConnection.fetchProduct(barcode: productBarcode) { (record) in

            let parser = ParseManager()
            guard let product = parser.parseProduct(data: record) else { return }

            completion(product)
        }
    }
}
