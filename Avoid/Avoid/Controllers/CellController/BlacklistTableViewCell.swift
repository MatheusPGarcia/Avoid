//
//  BlacklistTableViewCell.swift
//  Avoid
//
//  Created by Matheus Garcia on 14/08/18.
//  Copyright © 2018 Matheus Garcia. All rights reserved.
//

import UIKit

class BlacklistTableViewCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var selectionView: UIView!

    var state: Bool = false

    func setColor() {
        if state {
            selectionView.backgroundColor = UIColor.green
        } else {
            selectionView.backgroundColor = UIColor.lightGray
        }
    }
}
