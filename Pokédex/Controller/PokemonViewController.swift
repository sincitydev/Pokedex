//
//  PokemonViewController.swift
//  Pokédex
//
//  Created by Amanuel Ketebo on 12/14/17.
//  Copyright © 2017 SinCityDev. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonIDLabel: UILabel!
    @IBOutlet weak var pokemonHeightLabel: UILabel!
    @IBOutlet weak var pokemonWeightLabel: UILabel!
    @IBOutlet weak var pokemonCategoryLabel: UILabel!
    @IBOutlet weak var pokemonAbilitiesLabel: UILabel!
    
    var pokemon: Pokemon!
    let database = Database.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
