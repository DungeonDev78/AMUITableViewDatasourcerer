//
//  AMConfigurableCell.swift
//
//  Created with 💪 by Alessandro Manilii.
//  Copyright © 2018 Akhware. All rights reserved.
//

import Foundation

// Note that it conforms to the FVDReusableCell protocol
public protocol AMConfigurableCell: AMReusableCell {

    // Generic holding the model of the cell
    associatedtype T
    
    /// Configurator function made in order to populate the view of the cell
    ///
    /// - Parameters:
    ///   - item: the generic of the model for the cell
    ///   - indexPath: the indexPath of the cell in the tableView. Could be used sometimes...
    func configure(_ item: T, at indexPath: IndexPath)
}
