//
//  PokemonViewController.swift
//  Pokédex
//
//  Created by Amanuel Ketebo on 12/14/17.
//  Copyright © 2017 SinCityDev. All rights reserved.
//

import UIKit

class PokemonViewController: UIViewController {
    
    var pokemon: Pokemon!
    let database = Database.instance
    var pokemonStats: PokemonStatsResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        database.fetchPokemon(url: pokemon.url) { [weak self] (pokemonStatsResponse) in
            self?.pokemonStats = pokemonStatsResponse
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
