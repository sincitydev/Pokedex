//
//  TypesView.swift
//  Pokédex
//
//  Created by Amanuel Ketebo on 12/19/17.
//  Copyright © 2017 SinCityDev. All rights reserved.
//

import UIKit

enum Type: String {
    case grass = "Grass"
    case poison = "Poison"
    case fire = "Fire"
    case flying = "Flying"
    case water = "Water"
    case electric = "Electric"
    case ground = "Ground"
    case fairy = "Fairy"
    case bug = "Bug"
    case fighting = "Fighting"
    case psychic = "Psychic"
    case rock = "Rock"
    case steel = "Steel"
    case normal = "Normal"
}

class TypesView: UIView {
    var types: [String] = [] {
        didSet {
            reset()
            setupTypes()
            addTypesToView()
        }
    }
    var typeLabels = [UILabel]()
    var typeLabelWidthPadding: CGFloat = 8
    var typeLabelHeightPadding: CGFloat = 8
    var typeLabelCornerRadius: CGFloat = 5
    var typeLabelLeftSpacing: CGFloat = 3
    
    private var currentOffset: CGFloat = 0
    private var typeColors: [Type: UIColor] = [.grass: Theme.Colors.grassGreen, .poison: Theme.Colors.poisonBlue,
                                               .fire: Theme.Colors.fireRed, .flying: Theme.Colors.flyingBlue,
                                               .water: Theme.Colors.waterBlue, .electric: Theme.Colors.electricGray,
                                               .ground: Theme.Colors.groundBlack, .fairy: Theme.Colors.fairyPurple,
                                               .bug: Theme.Colors.bugGreen, .fighting: Theme.Colors.fightingPink,
                                               .psychic: Theme.Colors.psychicYellow, .rock: Theme.Colors.rockLightGray,
                                               .steel: Theme.Colors.steelBrown]
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupTypes() {
        types.forEach { (type) in
            let label = UILabel()
            label.text = type
            label.font = UIFont(name: "Menlo-Bold", size: 12)
            label.textColor = .white
            label.textAlignment = .center
            label.cornerRadius = typeLabelCornerRadius
            
            if let type = Type(rawValue: type),
                let typeColor = typeColors[type] {
                label.backgroundColor = typeColor
            } else {
                label.borderColor = .black
                label.textColor = .black
                label.borderWidth = 1
            }
            
            var size = label.intrinsicContentSize
            size.width += typeLabelWidthPadding
            size.height += typeLabelHeightPadding
            label.frame = CGRect(origin: .zero, size: size)
            typeLabels.append(label)
        }
    }
    
    private func addTypesToView() {
        typeLabels.forEach { (typeLabel) in
            typeLabel.frame.origin.x += currentOffset
            currentOffset += typeLabel.bounds.width
            currentOffset += typeLabelLeftSpacing
            addSubview(typeLabel)
        }
    }
    
    private func reset() {
        subviews.forEach { (view) in
            view.removeFromSuperview()
        }
        
        typeLabels.removeAll()
        currentOffset = 0
    }
}
