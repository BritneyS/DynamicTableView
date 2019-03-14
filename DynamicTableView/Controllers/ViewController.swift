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
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath) as? DynamicTableViewCell else {
            fatalError("Fatal error: No cell")
        }

        cell.wordLabel.text = wordArray[indexPath.row]
        print(cell.wordLabel.text!)
        print(cell.contentView.bounds.size.height)
        let hiddenWord = "lazy"
        
        cell.hideCellWith(word: hiddenWord)
        if cell.isHidden == true {
            textIsHidden = true
            wordArray.remove(at: indexPath.row)
            let indexPath = IndexPath(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .none)
        } else {
            textIsHidden = false
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //print("textIsHidden: \(textIsHidden)")
        return textIsHidden ? 0 : 50
        //return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        //return 50
    }
}

