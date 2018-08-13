//
//  ParseManager.swift
//  Avoid
//
//  Created by Matheus Garcia on 13/08/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation
import CloudKit

class ParseManager: NSObject {

    func parseProduct(data: [CKRecord]) -> Product? {

        guard let productData = data.first else { return nil }

        guard let name = productData["name"] as? String else { return nil }
        let recordId = productData.recordID

        let newProduct = Product(name: name, recordId: recordId)

        return newProduct
    }
}
