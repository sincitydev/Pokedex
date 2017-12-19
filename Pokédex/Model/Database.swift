//
//  Database.swift
//  Pokédex
//
//  Created by Amanuel Ketebo on 12/14/17.
//  Copyright © 2017 SinCityDev. All rights reserved.
//

import Foundation
import UIKit
import Apollo

enum DatabaseError: Error {
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
    let pokeApiGraphQLEndpoint = URL(string: "https://graphql-pokemon.now.sh")!
    lazy var apollo = ApolloClient(url: pokeApiGraphQLEndpoint)
    
    static let instance = Database()
    
    typealias PokemonsCallback = ([Pokemon]?, DatabaseError?) -> Void
    typealias PokemonPicCallback = (UIImage?, DatabaseError?) -> Void
    
    func fetchPokedex(firstNumberOfPokemon: Int, completion: @escaping PokemonsCallback) {
        var pokemons: [Pokemon] = []
        let pokemonQuery = PokemonsQuery(first: firstNumberOfPokemon)
        
        apollo.fetch(query: pokemonQuery) { result, error in
            if let _ = error {
                completion(nil, DatabaseError.fetchError)
                return
            } else if let graphQLPokemons = result?.data?.pokemons {
                graphQLPokemons.forEach({ (graphQLPokemon) in
                    if let pokemon = Pokemon(graphQLPokemon) {
                        pokemons.append(pokemon)
                    }
                })
                completion(pokemons, nil)
            }
        }
    }
    
    func fetchPokemonPic(url: URL, completion: @escaping PokemonPicCallback) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                DispatchQueue.main.async {
                    completion(nil, DatabaseError.fetchError)
                }
            } else {
                if let image = UIImage(data: data!) {
                    DispatchQueue.main.async {
                        completion(image, nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil, DatabaseError.parseError)
                    }
                }
            }
        }
        task.resume()
    }
}
