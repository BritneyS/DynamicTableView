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
    
    var wordArray: [String] {
        return "The quick brown fox jumps over the lazy dog".components(separatedBy: .whitespaces).map { $0 }
    }
    
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
        return cell
    }
    
    
}

