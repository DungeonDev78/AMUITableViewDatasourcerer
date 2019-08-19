//
//  AMUIImageView.swift
//  TVDatasource
//
//  Created with 💪 by Alessandro Manilii
//  Copyright © 2019 Alessandro Manilii. All rights reserved.
//

import UIKit

@IBDesignable
public class AMUIImageView: UIImageView {

    // MARK: - Properties
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet { self.layer.borderWidth = borderWidth }
    }

    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet { self.layer.borderColor = borderColor.cgColor }
    }

    @IBInspectable var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            self.clipsToBounds = true
        }
    }

}

