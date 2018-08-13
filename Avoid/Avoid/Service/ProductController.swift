//
//  ProductController.swift
//  Avoid
//
//  Created by Matheus Garcia on 13/08/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation
import CloudKit

class ProductController: NSObject {

    func findProductOnDatabse(productBarcode: String) -> Product? {

        _ = CloudKitConnectivity().fetchProduct(barcode: productBarcode) { (record) in
            print("at least here we got! With this fucking data: \(record)")
        }

        return nil
    }
}
