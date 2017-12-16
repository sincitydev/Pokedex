//
//  ViewController.swift
//  Pokédex
//
//  Created by Amanuel Ketebo on 12/14/17.
//  Copyright © 2017 SinCityDev. All rights reserved.
//

import UIKit

class PokedexViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    let edgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    
    var pokemons = [Pokemon]()
    var pokedexResponse: PokedexResponse?
    
    let database = Database.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        activityIndicator.startAnimating()
        database.fetchPokedex { [weak self] (pokedexResponse) in
            self?.pokedexResponse = pokedexResponse
            self?.pokemons = pokedexResponse?.results ?? []
            self?.activityIndicator.stopAnimating()
            self?.collectionView.reloadData()
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


extension PokedexViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as! PokeCollectionCell
        let pokemon = pokemons[indexPath.item]
    
        cell.configureCell(pokemon: pokemon)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = collectionView.bounds.width
        let availableWidth = totalWidth - (edgeInsets.left + edgeInsets.right)
        let cellWidth = availableWidth / 2

        return CGSize(width: cellWidth - 5, height: 280)
    }
    
<<<<<<< Updated upstream
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let pokemon = pokedexResponse?.results[indexPath.row] {
            performSegue(withIdentifier: "showPokemon", sender: pokemon)
        } else {
            print("Couldn't make pokemon!")
        }
    }
    
    
    
    
=======
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return edgeInsets
    }
>>>>>>> Stashed changes
}








