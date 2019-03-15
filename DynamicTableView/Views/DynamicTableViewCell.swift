//
//  DynamicTableViewCell.swift
//  DynamicTableView
//
//  Created by Britney Smith on 3/12/19.
//  Copyright © 2019 Britney Smith. All rights reserved.
//

import UIKit

enum CellType {
    case labelCell
    case dogImageCell
}

class DynamicTableViewCell: UITableViewCell {

    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var dogImage: UIImageView!
    
}
