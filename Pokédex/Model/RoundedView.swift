//
//  RoundedView.swift
//  Pokédex
//
//  Created by Joshua Ramos on 12/15/17.
//  Copyright © 2017 SinCityDev. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedView: UIView {
    @IBInspectable override var cornerRadius: CGFloat {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable override var borderWidth: CGFloat {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable override var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
}
