//
//  BlacklistIngredient.swift
//  Avoid
//
//  Created by Matheus Garcia on 16/08/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation
import CloudKit

struct BlacklistIngredient {

    var ingredientRecordName: String
    var selfReferenceId: CKRecordID

    init(name ingredientRecordName: String, reference selfReferenceId: CKRecordID) {
        self.ingredientRecordName = ingredientRecordName
        self.selfReferenceId = selfReferenceId
    }
}
