//
//  Extensions.swift
//  Pokédex
//
//  Created by Amanuel Ketebo on 12/15/17.
//  Copyright © 2017 SinCityDev. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    static let showPokemonSegue = "showPokemon"
}

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            if let borderColor = layer.borderColor {
                return UIColor(cgColor: borderColor)
            } else {
                return nil
            }
        }
        set {
            layer.borderColor = borderColor?.cgColor
        }
    }
}
