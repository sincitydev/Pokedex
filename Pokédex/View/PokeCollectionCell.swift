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
    
    func configureCell(pokemon: Pokemon) {
        pokemonNameLabel.text = pokemon.name
    }
}
