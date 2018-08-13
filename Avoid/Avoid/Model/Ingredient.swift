//
//  Ingredient.swift
//  Avoid
//
//  Created by Matheus Garcia on 09/08/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation
import CloudKit

struct Ingredient {

    var name: String
    var recordId: CKRecordID

    init(name: String, recordId: CKRecordID) {
        self.name = name
        self.recordId = recordId
    }
}
