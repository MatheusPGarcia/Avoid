//
//  BlacklistViewController.swift
//  Avoid
//
//  Created by Matheus Garcia on 14/08/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import Foundation
import UIKit

class BlacklistViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var ingredients = [Ingredient]()
    var ingredientsSelected = [Ingredient]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let ingredients = IngredientsController()
        ingredients.findAllTheIngredients { (ingredients) in
            self.ingredients = ingredients
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    @IBAction func saveBlacklist(_ sender: UIButton) {
        let controller = BlacklistController()
        controller.saveInitialBlacklist(ingredientsSelected) { (status) in
            if status {
                print("Success")
            } else {
                print("Failure")
            }
        }
    }

}

extension BlacklistViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BlacklistTableViewCell") as? BlacklistTableViewCell else {
            return UITableViewCell()
        }

        cell.title.text = ingredients[indexPath.row].name
        cell.state = ingredients[indexPath.row].state
        cell.setColor()

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cellSelected = tableView.cellForRow(at: indexPath) as? BlacklistTableViewCell else {
            return
        }

        ingredients[indexPath.row].state = !ingredients[indexPath.row].state
        let currentIngredient = ingredients[indexPath.row]

        if currentIngredient.state == true {
            
            ingredientsSelected.append(currentIngredient)
        } else {
            var index = 0

            for ingredientInTest in ingredientsSelected {
                if ingredientInTest == currentIngredient {
                    break
                }
                index += 1
            }

            ingredientsSelected.remove(at: index)
        }

        cellSelected.state = currentIngredient.state
        cellSelected.setColor()
    }
}
