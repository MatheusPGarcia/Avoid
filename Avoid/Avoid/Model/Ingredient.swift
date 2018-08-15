//
//  Ingredient.swift
//  Avoid
//
//  Created by Matheus Garcia on 09/08/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation
import CloudKit

struct Ingredient: Equatable {

    var name: String
    var recordId: CKRecordID
    var state: Bool

    init(name: String, recordId: CKRecordID) {
        self.name = name
        self.recordId = recordId
        state = false
    }
}

func == (lhs: Ingredient, rhs: Ingredient) -> Bool {
    if lhs.name == rhs.name && lhs.recordId == rhs.recordId {
        return true
    }
    return false
}
