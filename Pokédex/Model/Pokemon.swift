//
//  Pokemon.swift
//  Pokédex
//
//  Created by Amanuel Ketebo on 12/14/17.
//  Copyright © 2017 SinCityDev. All rights reserved.
//

import Foundation

struct Pokemon {
    var name: String
    var imageURL: URL
    var types: [String] = []
}

struct Weight {
    var minimum: String
    var maximum: String
}

struct Height {
    var minimum: String
    var maximum: String
}

extension Pokemon {
    init?(_ graphQLPokemon: PokemonsQuery.Data.Pokemon?) {
        if let graphQLPokemon = graphQLPokemon,
            let name = graphQLPokemon.name,
            let imageURLString = graphQLPokemon.image,
            let imageURL = URL(string: imageURLString) {
            self.name = name
            self.imageURL = imageURL
            
            if let graphQLPokemonTypes = graphQLPokemon.types {
                graphQLPokemonTypes.forEach({ (graphQLPokemonType) in
                    if let pokemonType = graphQLPokemonType {
                        types.append(pokemonType)
                    }
                })
            }
            
        } else {
            return nil
        }
    }
}
