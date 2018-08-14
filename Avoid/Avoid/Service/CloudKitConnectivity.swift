//
//  CloudKitConnectivity.swift
//  Avoid
//
//  Created by Matheus Garcia on 13/08/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitConnectivity: NSObject {

    func fetchProduct(barcode: String, completion: @escaping ([CKRecord]) -> Void) {

        let publicDatabase = CKContainer.default().publicCloudDatabase

        let category = "Product"
        let predicate = "barcode"

        // Generate query's predicate
        let predicateValue = NSPredicate(format: "\(predicate) = %@", barcode)

        // Perform request
        let query = CKQuery(recordType: category, predicate: predicateValue)
        publicDatabase.perform(query, inZoneWith: nil) { (record, error) in

            if !self.recordFeedback(category: category, record: record, error: error) {
                return
            }

            completion(record!)
        }
    }

    func fetchIngredients(product: Product? = nil, completion: @escaping ([CKRecord]) -> Void) {

        let publicDatabase = CKContainer.default().publicCloudDatabase

        let category = "Ingredient"
        var predicateValue = NSPredicate(value: true)

        if let product = product {
            let idReference = CKReference(recordID: product.recordId, action: .deleteSelf)

            // Generate query's predicate
            predicateValue = NSPredicate(format: "%@ IN products", idReference)
        }

        // Perform request
        let query = CKQuery(recordType: category, predicate: predicateValue)
        publicDatabase.perform(query, inZoneWith: nil) { (record, error) in

            if !self.recordFeedback(category: category, record: record, error: error) {
                return
            }

            completion(record!)
        }
    }

    func recordFeedback(category: String, record: [CKRecord]?, error: Error?) -> Bool {

        if let error = error {
            print("ops, something went wrong while trying to query \(category):\n\(error)")
            return false
        }

         if record == nil {
            print("the \(category) list is empty")
            return false
        }

        return true
    }
}
