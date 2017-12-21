//
//  PokeCollectionCell.swift
//  Pokédex
//
//  Created by Joshua Ramos on 12/15/17.
//  Copyright © 2017 SinCityDev. All rights reserved.
//

import UIKit

class PokemonCell: UICollectionViewCell {
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var typesView: TypesView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    static let identifier = "PokemonCell"
    
    func configureCell(pokemon: Pokemon) {
        pokemonNameLabel.text = pokemon.name
        pokemonImageView.image = nil
        addCellShadow()
        typesView.types = pokemon.types
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
    }
    
    private func addCellShadow() {
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 3.0)
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 0.8
        self.layer.masksToBounds = false
    }
}
