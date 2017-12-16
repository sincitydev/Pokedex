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

struct PokemonStatsResponse: Codable {
    var id: Int
    var height: Int
    var weight: Int
}

struct Pokemon: Codable {
    var id: Int?
    var name: String
    var url: URL
    var height: Int?
    var weight: Int?
    
    var hasAllData: Bool {
        if let _ = id, let _ = height, let _ = weight {
            return true
        } else {
            return false
        }
    }
    
    init(name: String, url: URL) {
        self.name = name
        self.url = url
    }
}
