//
//  Database.swift
//  Pokédex
//
//  Created by Amanuel Ketebo on 12/14/17.
//  Copyright © 2017 SinCityDev. All rights reserved.
//

import Foundation

enum PokedexError: Error {
    case fetchError
    case parseError
    
    var localizedDescription: String {
        switch self {
        case .fetchError: return "Error fetching data from Pokeapi"
        case .parseError: return "Error parsing data from Pokeapi"
        }
    }
}

class Database {
    static let instance = Database()
    
    typealias PokedexCallback = (PokedexResponse?, Error?) -> Void
    typealias PokemonStatsCallback = (PokemonStatsResponse?, Error?) -> Void
    
    private var api = URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=100")!
    
    func fetchPokedex(completion: @escaping PokedexCallback) {
        var pokedexResponse: PokedexResponse?
        
        let task = URLSession.shared.dataTask(with: api) { (data, response, error) in
            if let _ = error {
                completion(nil, PokedexError.fetchError)
            } else {
                let decoder = JSONDecoder()

                pokedexResponse = try? decoder.decode(PokedexResponse.self, from: data!)
                
                DispatchQueue.main.async {
                    if pokedexResponse != nil {
                        completion(pokedexResponse, nil)
                    } else {
                        completion(nil, PokedexError.parseError)
                    }
                }
            }
        }
        task.resume()
    }
    
    func fetchPokemon(url: URL, completion: @escaping PokemonStatsCallback) {
        var pokemonStatsResponse: PokemonStatsResponse?
    
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(nil, PokedexError.fetchError)
            } else {
                let decoder = JSONDecoder()
                
                pokemonStatsResponse = try? decoder.decode(PokemonStatsResponse.self, from: data!)
            }
            
            DispatchQueue.main.async {
                if pokemonStatsResponse == nil {
                    completion(pokemonStatsResponse, nil)
                } else {
                    completion(nil, PokedexError.parseError)
                }
            }
        }
        task.resume()
    }
}
