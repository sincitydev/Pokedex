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
    var pokemonStats: PokedexResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        database.fetchPokemon(url: pokemon.url) { [weak self] (pokeResponse, pokedexError) in
//            if let pokedexError = pokedexError {
//                // Present user with some sort of error
//                print(pokedexError.localizedDescription)
//            } else {
//                self?.pokemonStats = pokemonStatsResponse
//                self?.pokemonNameLabel.text = self?.pokemonStats?.name
//                self?.pokemonIDLabel.text = String(describing: self?.pokemonStats?.id)
//                self?.pokemonWeightLabel.text = String(describing: self?.pokemonStats?.weight)
//            }
//        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
