//
//  AMReusableCell.swift
//
//  Created with 💪 by Alessandro Manilii.
//  Copyright © 2018 Akhware. All rights reserved.
//

import Foundation

public protocol AMReusableCell {
    // The identifier of the cell itself, is the name of the class
    static var reuseIdentifier: String { get }
}

public extension AMReusableCell {
    /// Computed var that returns the name of the cell class
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
