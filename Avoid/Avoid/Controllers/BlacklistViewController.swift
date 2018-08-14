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

        return cell
    }
}
