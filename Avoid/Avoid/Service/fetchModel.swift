//
//  fetchModel.swift
//  Avoid
//
//  Created by Matheus Garcia on 09/08/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation
import CloudKit

struct fetchModel {

    var recordType: String?
    var predicate: String?
    var reference: CKReference?
    var cKDatabase: CKDatabase?
}
