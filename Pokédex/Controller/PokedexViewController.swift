//
//  ViewController.swift
//  Pokédex
//
//  Created by Amanuel Ketebo on 12/14/17.
//  Copyright © 2017 SinCityDev. All rights reserved.
//

import UIKit

class PokedexViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    var pokemons = [Pokemon]()
    var pokedexResponse: PokedexResponse?
    
    let database = Database.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        activityIndicator.startAnimating()
        database.fetchPokedex { [weak self] (pokedexResponse) in
            self?.pokedexResponse = pokedexResponse
            self?.pokemons = pokedexResponse?.results ?? []
            self?.activityIndicator.stopAnimating()
            self?.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pokemon = sender as? Pokemon,
            let pokemonVC = segue.destination as? PokemonViewController {
            pokemonVC.pokemon = pokemon
        } else {
            print("Couldn't make pokemon and segue!")
        }
    }
}

extension PokedexViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PokemonCell.identifier) as! PokemonCell
        
        cell.pokemonName.text = pokemons[indexPath.row].name
        
        return cell
    }
    
    // Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let pokemon = pokedexResponse?.results[indexPath.row] {
            performSegue(withIdentifier: "showPokemon", sender: pokemon)
        } else {
            print("Couldn't make pokemon!")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
