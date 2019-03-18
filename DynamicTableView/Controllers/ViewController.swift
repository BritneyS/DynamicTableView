//
//  ViewController.swift
//  DynamicTableView
//
//  Created by Britney Smith on 3/12/19.
//  Copyright © 2019 Britney Smith. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var wordArray = "The quick brown fox jumps over the lazy dog".components(separatedBy: .whitespaces).map { $0 } {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerDynamicTableViewCell()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func registerDynamicTableViewCell() {
        let cell = UINib(nibName: "LabelCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "LabelCell")
        
        let dogImageCell = UINib(nibName: "ImageCell", bundle: nil)
        tableView.register(dogImageCell, forCellReuseIdentifier: "ImageCell")
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if wordArray[indexPath.row] == "dog" {
            guard let imageCell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as? DynamicTableViewCell else { fatalError("Fatal error: No image cell") }
            return imageCell
        } else {
            guard let labelCell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as? DynamicTableViewCell else { fatalError("Fatal error: No label cell") }
            labelCell.wordLabel.text = wordArray[indexPath.row]
            let hiddenWord = "lazy"
            if wordArray[indexPath.row] == hiddenWord {
                wordArray.remove(at: indexPath.row)
                let indexPath = IndexPath(index: indexPath.row)
                tableView.performBatchUpdates(({
                    tableView.deleteRows(at: [indexPath], with: .none)
                    tableView.reloadRows(at: [indexPath], with: .none)
                }), completion: nil)
            }
            return labelCell
        }
    }
}

