//
//  CloudKitConnectivity.swift
//  Avoid
//
//  Created by Matheus Garcia on 13/08/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation
import CloudKit

class CloudKitConnectivity {

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

    func loadBlacklist(completion: @escaping ([CKRecord]) -> Void) -> Bool {

        let privateDatabase = CKContainer.default().privateCloudDatabase

        let category = "Blacklist"
        let predicateValue = NSPredicate(value: true)
        let zone = CKRecordZone(zoneName: "Blacklist")

        let query = CKQuery(recordType: category, predicate: predicateValue)
        privateDatabase.perform(query, inZoneWith: zone.zoneID) { (record, error) in

            if !self.recordFeedback(category: category, record: record, error: error) {
                return
            }

            completion(record!)
        }

        return true
    }

    func saveBlacklist(add: [Ingredient], remove: [BlacklistIngredient]) -> Bool {

        let privateDatabase = CKContainer.default().privateCloudDatabase
        let zone = CKRecordZone(zoneName: "Blacklist")

        var addRecords = [CKRecord]()

        for ingredient in add {
            let record = CKRecord(recordType: "Blacklist", zoneID: zone.zoneID)

            let ingredientRecord = ingredient.recordId.recordName as CKRecordValue
            record.setObject(ingredientRecord, forKey: "ingredients")

            addRecords.append(record)
        }

        var removeRecords = [CKRecordID]()

        for ingredient in remove {
            let recordId = ingredient.selfReferenceId

            removeRecords.append(recordId)
        }

        let operation = CKModifyRecordsOperation(recordsToSave: addRecords, recordIDsToDelete: removeRecords)

        let configuration = CKOperationConfiguration()
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10

        operation.configuration = configuration

        operation.modifyRecordsCompletionBlock = { (savedRecords, deletedRecords, error) in

            if let error = error {
                print("Error modifyng records: \(error)")
            } else {
                print("Record modified with success")
            }
        }

        privateDatabase.add(operation)

        return true
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

    func startBlacklistZone(completion: @escaping () -> Void) {

        let privateDatabase = CKContainer.default().privateCloudDatabase
        let zone = CKRecordZone(zoneName: "Blacklist")

        privateDatabase.save(zone) { (_, error) in
            if let error = error {
                print("Unable to create zone, error: \(error)")
            } else {
                print("Zone was created")
                completion()
            }
        }
    }
}
