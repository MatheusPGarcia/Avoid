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

    var idsSelectedFromCK = [BlacklistIngredient]()

    var ingredientsSelected = [Ingredient]()
    var ingredientsToRemove = [BlacklistIngredient]()
    var ingredientsToAdd = [Ingredient]()

    var ingredientsAreLoaded: Bool = true
    var selectedAreLoaded: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        ingredientsAreLoaded = false
        selectedAreLoaded = false

        let ingredients = IngredientsController()

        ingredients.findAllTheIngredients { (ingredients) in
            self.ingredients = ingredients
            self.ingredientsAreLoaded = true

            self.updateTableView()
        }

        let blacklist = BlacklistController()
        blacklist.loadBlacklist { (blacklistIngredients) in

            self.idsSelectedFromCK = blacklistIngredients
            self.selectedAreLoaded = true

            self.updateTableView()
        }
    }

    func updateTableView() {
        if ingredientsAreLoaded && selectedAreLoaded {

            self.getSelectedFromCK()

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    @IBAction func saveBlacklist(_ sender: UIButton) {
        let controller = BlacklistController()

        ingredientsToRemove = getRemovables()
        ingredientsToAdd = getNewAdd()

        controller.saveBlacklist(add: ingredientsToAdd, remove: ingredientsToRemove) { (status) in
            if status {
                print("Success")
            } else {
                print("Failure")
            }
        }
    }

    func getRemovables() -> [BlacklistIngredient] {

        var removedArray = [BlacklistIngredient]()

        for currentId in idsSelectedFromCK {

            var found = false
            let ckRecordName = currentId.ingredientRecordName

            for currentIngredient in ingredientsSelected {

                let ingredientRecordName = currentIngredient.recordId.recordName

                if ingredientRecordName == ckRecordName {
                    found = true
                }
            }

            if !found {
                removedArray.append(currentId)
            }
        }

        return removedArray
    }

    func getNewAdd() -> [Ingredient] {

        var addArray = [Ingredient]()

        for currentIngredient in ingredientsSelected {

            var found = false
            let ingredientRecordName = currentIngredient.recordId.recordName

            for currentId in idsSelectedFromCK {

                let lookingRecordName = currentId.ingredientRecordName

                if ingredientRecordName == lookingRecordName {
                    found = true
                }
            }

            if !found {
                addArray.append(currentIngredient)
            }
        }

        return addArray
    }

    func getSelectedFromCK() {
        for currentId in idsSelectedFromCK {

            var index = 0
            let idRecordName = currentId.ingredientRecordName

            for currentIngredient in ingredients {

                let ingredientRecordName = currentIngredient.recordId.recordName

                if ingredientRecordName == idRecordName {

                    self.ingredients[index].state = true
                    ingredientsSelected.append(self.ingredients[index])
                }

                index += 1
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
