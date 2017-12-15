//
//  Pokemon.swift
//  Pokédex
//
//  Created by Amanuel Ketebo on 12/14/17.
//  Copyright © 2017 SinCityDev. All rights reserved.
//

import Foundation

struct PokedexResponse: Codable {
    var count: Int
    var previous: String?
    var results: [Pokemon]
}

struct Pokemon: Codable {
    var name: String
    var url: URL
    
    init(name: String, url: URL) {
        self.name = name
        self.url = url
    }
}

struct PokemonStatsResponse: Codable {
    var id: Int
    var name: String
    var height: Int
    var weight: Int
    var forms: [PokemonForms]
}

struct PokemonForms: Codable {
    var name: String
    var url: URL
}