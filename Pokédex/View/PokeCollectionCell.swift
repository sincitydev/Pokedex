//
//  PokeCollectionCell.swift
//  Pokédex
//
//  Created by Joshua Ramos on 12/15/17.
//  Copyright © 2017 SinCityDev. All rights reserved.
//

import UIKit

class PokeCollectionCell: UICollectionViewCell {
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    static let identifier = "PokeCell"
    
    func configureCell(pokemon: Pokemon) {
        pokemonNameLabel.text = pokemon.name
        
        if let pokemonID = pokemon.id {
            pokemonIDLabel.text = "id: \(String(pokemonID))"
        } else {
            pokemonIDLabel.text = ""
        }
    }
}






















