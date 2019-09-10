//
//  ViewController.swift
//  AMTVDatasourcererExample
//
//  Created by Alessandro Manilii on 16/08/2019.
//  Copyright © 2019 Akhware. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: AMUITableViewDatasourcerer<CharacterModel, CharacterCell>?

    override func viewDidLoad() {
        super.viewDidLoad()
//        dataSource = AMUITableViewDatasourcerer.init(items: CharacterFactory.createListOfCharacters(), cellClass: CharacterCell.self)
        dataSource = AMUITableViewDatasourcerer.init(multiSectionItems: CharacterFactory.createMultisectionCharacters(), cellClass: CharacterCell.self)
        tableView.dataSource = dataSource
    }

    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing
        let newButton = UIBarButtonItem(barButtonSystemItem: (tableView.isEditing) ? .done : .edit, target: self, action: #selector(editButtonPressed(_:)))
        self.navigationItem.rightBarButtonItem = newButton
    }
    
}

