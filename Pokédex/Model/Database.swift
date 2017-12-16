//
//  Database.swift
//  Pokédex
//
//  Created by Amanuel Ketebo on 12/14/17.
//  Copyright © 2017 SinCityDev. All rights reserved.
//

import Foundation

class Database {
    static let instance = Database()
    
    typealias PokedexCallback = (PokedexResponse?) -> Void
    typealias PokemonCallback = (PokemonStatsResponse?) -> Void
    
    private var api = URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=100")!
    

    
    func fetchPokedex(completion: @escaping PokedexCallback) {
        var pokedexResponse: PokedexResponse?
        
        let task = URLSession.shared.dataTask(with: api) { (data, response, error) in
            if let _ = error {
                print("Error fetching pokemon")
            } else {
                let decoder = JSONDecoder()

                pokedexResponse = try? decoder.decode(PokedexResponse.self, from: data!)
            }
            
            DispatchQueue.main.async {
                completion(pokedexResponse)
            }
        }
        task.resume()
    }
    
    func fetchPokemon(url: URL, completion: @escaping PokemonCallback) {
        var pokemonStatsResponse: PokemonStatsResponse?
    
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                print("Error fetching pokemon stats")
            } else {
                let decoder = JSONDecoder()
                
                pokemonStatsResponse = try? decoder.decode(PokemonStatsResponse.self, from: data!)
            }
            
            DispatchQueue.main.async {
                completion(pokemonStatsResponse)
            }
        }
        task.resume()
    }
    
    //func fetchPokemonInfo(url: URL, completion: @escaping )
}
