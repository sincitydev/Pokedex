//
//  pokemonCell.swift
//  Pokédex
//
//  Created by Amanuel Ketebo on 12/14/17.
//  Copyright © 2017 SinCityDev. All rights reserved.
//

import UIKit

class PokemonCell: UITableViewCell {
    @IBOutlet weak var pokemonName: UILabel!
    
    static let identifier = "PokemonCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
