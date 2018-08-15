//
//  BlacklistController.swift
//  Avoid
//
//  Created by Matheus Garcia on 15/08/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation

class BlacklistController {

    func saveInitialBlacklist(_ ingredients: [Ingredient], completion: @escaping (Bool) -> Void) {

        let databaseConnection = CloudKitConnectivity()
        databaseConnection.saveBlacklist(ingredients: ingredients)
//        databaseConnection.startBlacklistZone {
////            databaseConnection.saveBlacklist(value: <#T##CKRecordValue#>)
//        }
    }
}
