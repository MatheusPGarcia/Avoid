//
//  DatabaseService.swift
//  Avoid
//
//  Created by Matheus Garcia on 09/08/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation
import CloudKit

class DatabaseService: NSObject {

    func fetchBlacklist(fromModel model: FetchModel, completion: @escaping ([CKRecord]) -> Void) {

        let privateDatabase = CKContainer.default().privateCloudDatabase
        var newModel = model
        newModel.cKDatabase = privateDatabase

        fetch(fromModel: newModel) { (record) in
            completion(record)
        }
    }

    func fetchProductOrIngredient(fromModel model: FetchModel, completion: @escaping ([CKRecord]) -> Void) {

        let publicDatabase = CKContainer.default().publicCloudDatabase
        var newModel = model
        newModel.cKDatabase = publicDatabase

        fetch(fromModel: newModel) { (record) in
            completion(record)
        }
    }

    private func fetch(fromModel model: FetchModel, completion: @escaping ([CKRecord]) -> Void) {

        var predicateValue: NSPredicate

        // Generate the predicate for Query
        if let predicate = model.predicate, let reference = model.reference {
            predicateValue = NSPredicate(format: "\(predicate) = %@", reference)
        } else {
            predicateValue = NSPredicate(value: true)
        }

        guard let recordType = model.recordType else { return }

        // Perform the request
        let query = CKQuery(recordType: recordType, predicate: predicateValue)
        model.cKDatabase?.perform(query, inZoneWith: nil) { (recordReference, error) in

            if let error = error {
                print("ops, something went wrong while trying to query \(recordType):\n\(error)")
                return
            }

            guard let record = recordReference else {
                print("the \(recordType) list is empty")
                return
            }

            completion(record)
        }
    }
}
