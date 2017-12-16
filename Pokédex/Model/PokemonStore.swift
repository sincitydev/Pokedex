//
//  PokemonStore.swift
//  Pokédex
//
//  Created by Amanuel Ketebo on 12/16/17.
//  Copyright © 2017 SinCityDev. All rights reserved.
//

import Foundation

class PokemonStore {
    static let shared = PokemonStore()
    
    var pokemonsArray: [Pokemon] = [] {
        didSet {
            updatePokemonsDict()
        }
    }
    var pokemonsDict: [Int: Pokemon] = [:]
    
    func pokemon(with name: String) -> Pokemon? {
        var foundPokemon: Pokemon?
        
        pokemonsArray.forEach { (pokemon) in
            if pokemon.name == name {
                foundPokemon = pokemon
            }
        }
        
        return foundPokemon
    }
    
    func pokemon(with id: Int) -> Pokemon? {
        return pokemonsDict[id]
    }
    
    func updateStore(pokedexResponse: PokedexResponse) {
        pokemonsArray = pokedexResponse.results
    }
    
    private func updatePokemonsDict() {
        pokemonsArray.forEach { (pokemon) in
            if let id = pokemon.id {
                pokemonsDict[id] = pokemon
            }
        }
    }
}
