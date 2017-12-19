//
//  TypesView.swift
//  Pokédex
//
//  Created by Amanuel Ketebo on 12/19/17.
//  Copyright © 2017 SinCityDev. All rights reserved.
//

import UIKit

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
    
    private var currentOffset: CGFloat = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupTypes() {
        types.forEach { (type) in
            let label = UILabel()
            label.text = type
            label.font = UIFont(name: "Menlo-Bold", size: 12)
            label.textColor = .white
            label.backgroundColor = .red
            label.textAlignment = .center
            label.cornerRadius = typeLabelCornerRadius
            
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
