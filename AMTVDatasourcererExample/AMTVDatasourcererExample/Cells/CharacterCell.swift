//
//  CharacterCell.swift
//  AMTVDatasourcererExample
//
//  Created by Alessandro Manilii on 16/08/2019.
//  Copyright © 2019 Akhware. All rights reserved.
//

import UIKit

class CharacterCell: UITableViewCell, AMConfigurableCell {

    typealias T = CharacterModel

    @IBOutlet weak var vImage: AMUIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblFirstAppearance: UILabel!
    var indexPath:IndexPath?

    func configure(_ item: CharacterModel, at indexPath: IndexPath) {
        lblName.text = "\(item.firstName) \(item.lastName ?? "")"
        lblFirstAppearance.text = item.universe
        vImage.image = item.image
        indexPath.row.isMultiple(of: 2) ? (backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)) : (backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
    }
}
