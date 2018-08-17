//
//  FeedbackViewController.swift
//  Avoid
//
//  Created by Matheus Garcia on 17/08/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation
import UIKit

class FeedbackViewController: UIViewController {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productIngredientsLabel: UILabel!
    
    var product: Product?
    var blacklist = [BlacklistIngredient]()
    var occurrences = [Ingredient]()

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let product = product else { return }

        productNameLabel.text = product.name

        var ingredients: String = ""
        for ingredient in product.ingredientes {
            ingredients = "\(ingredients)\(ingredient.name)\n"
        }

        productIngredientsLabel.text = ingredients

        getBlacklist()
    }

    func getBlacklist() {
        let blacklist = BlacklistController()
        blacklist.loadBlacklist { (blacklistIngredients) in

            self.blacklist = blacklistIngredients
            self.getBlacklistOccurrences()
        }
    }

    func getBlacklistOccurrences() {

        guard let product = product else { return }

        for blacklistItem in blacklist {
            let blacklistID = blacklistItem.ingredientRecordName

            for ingredient in product.ingredientes {
                let productIngredientID = ingredient.recordId.recordName

                if blacklistID == productIngredientID {
                    self.occurrences.append(ingredient)
                }
            }
        }

        var ingredients: String = ""
        for ingredient in product.ingredientes {
            ingredients = "\(ingredients)\(ingredient.name)\n"
        }

        ingredients = "\(ingredients)\nFrom here only blacklist:\n"
        for this in occurrences {
            ingredients = "\(ingredients)\(this.name)\n"
        }

        DispatchQueue.main.async {
            self.productIngredientsLabel.text = ingredients
        }
    }

    @IBAction func goBack(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
