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

            if let error = error {
                print("ops, something went wrong while trying to query \(category):\n\(error)")
                return
            }

            guard let record = record else {
                print("the \(category) list is empty")
                return
            }

            completion(record)
        }
    }
}
