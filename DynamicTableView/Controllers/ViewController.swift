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
    
    var textIsHidden = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerDynamicTableViewCell()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func registerDynamicTableViewCell() {
        let cell = UINib(nibName: "DynamicTableViewCell", bundle: nil)
        tableView.register(cell, forCellReuseIdentifier: "DynamicTableViewCell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wordArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DynamicTableViewCell", for: indexPath) as? DynamicTableViewCell else {
            fatalError("Fatal error: No cell")
        }

        cell.wordLabel.text = wordArray[indexPath.row]
        let hiddenWord = "lazy"
        
        cell.hideCellWith(word: hiddenWord)
        if cell.isHidden == true {
            wordArray.remove(at: indexPath.row)
            let indexPath = IndexPath(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .none)
            textIsHidden = true
        } else {
            textIsHidden = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return textIsHidden ? 0 : 50
    }
}

