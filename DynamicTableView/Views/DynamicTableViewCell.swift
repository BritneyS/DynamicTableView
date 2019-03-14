//
//  DynamicTableViewCell.swift
//  DynamicTableView
//
//  Created by Britney Smith on 3/12/19.
//  Copyright © 2019 Britney Smith. All rights reserved.
//

import UIKit

class DynamicTableViewCell: UITableViewCell {

    @IBOutlet weak var wordLabel: UILabel!
    
    func hideCellWith(word: String) {
        if wordLabel.text == word {
            isHidden = true
        } else {
            isHidden = false
        }
    }
}
