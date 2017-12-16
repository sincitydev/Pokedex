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
    let numberItemsPerRow = 2
    let pokemonCellEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    let pokemonCellHeight: CGFloat = 280
    
    var pokemonStore = PokemonStore.shared
    
    let database = Database.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        fetchPokedex()
    }
    
    private func setupViews() {
        let blackColorAttribute = [NSAttributedStringKey.foregroundColor: UIColor.black]
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.titleTextAttributes = blackColorAttribute
        navigationController?.navigationBar.largeTitleTextAttributes = blackColorAttribute
        
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.frame.origin.y -= 100
        activityIndicator.hidesWhenStopped = true
        
        activityIndicator.startAnimating()
    }
    
    private func fetchPokedex() {
        database.fetchPokedex { [weak self] (pokedexResponse, pokedexError) in
            if let pokedexError = pokedexError {
                // Present user with some error
                print(pokedexError.localizedDescription)
            } else {
                self?.pokemonStore.pokemonsArray = pokedexResponse?.results ?? []
                self?.activityIndicator.stopAnimating()
                self?.collectionView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pokemon = sender as? Pokemon,
            let pokemonVC = segue.destination as? PokemonViewController {
            pokemonVC.pokemon = pokemon
        }
    }
}


extension PokedexViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemonStore.pokemonsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCell.identifier, for: indexPath) as! PokeCollectionCell
        var pokemon = pokemonStore.pokemonsArray[indexPath.row]
        
        cell.tag = indexPath.row
        
        cell.configureCell(pokemon: pokemon)
        
        if !pokemon.hasAllData {
            print("Pokemon doesn't have all the data!")
            // Fetch data
            database.fetchPokemon(url: pokemon.url, completion: { [weak self] (pokemonStatsResponse, error) in
                if error != nil {
                    // Present user with error
                } else {
                    if cell.tag == indexPath.row {
                        pokemon.height = pokemonStatsResponse?.height
                        pokemon.id = pokemonStatsResponse?.height
                        pokemon.weight = pokemonStatsResponse?.weight
                        self?.pokemonStore.pokemonsArray[indexPath.row] = pokemon
                        cell.configureCell(pokemon: pokemon)
                    }
                }
            })
        } else {
            cell.configureCell(pokemon: pokemon)
        }
        
        return cell
    }
}

extension PokedexViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pokemon = pokemonStore.pokemonsArray[indexPath.row]
        
        performSegue(withIdentifier: UIStoryboard.showPokemonSegue, sender: pokemon)
    }
}

extension PokedexViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let availableWidth = collectionView.bounds.width
        let insetTotalWidth = CGFloat((pokemonCellEdgeInsets.left * CGFloat((numberItemsPerRow + 1))))
        let cellWidth = (availableWidth - insetTotalWidth) / CGFloat(numberItemsPerRow)
        
        return CGSize(width: cellWidth, height: pokemonCellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return pokemonCellEdgeInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return pokemonCellEdgeInsets.bottom
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
