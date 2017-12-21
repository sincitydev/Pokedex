//
//  ViewController.swift
//  Pokédex
//
//  Created by Amanuel Ketebo on 12/14/17.
//  Copyright © 2017 SinCityDev. All rights reserved.
//

import UIKit

class PokedexViewController: UICollectionViewController {
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    let numberItemsPerRow = 2
    let pokemonCellEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    let pokemonCellHeight: CGFloat = 220
    let animationVC: TimeInterval = 0.4
    
    var pokemons: [Pokemon] = []
    let database = Database.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchPokedex()
    }
    
    private func setupViews() {
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.frame.origin.y -= 100
        activityIndicator.hidesWhenStopped = true
    }
    
    private func fetchPokedex() {
        activityIndicator.startAnimating()
        
        database.fetchPokedex(firstNumberOfPokemon: 100) { [weak self] (pokemons, databaseError) in
            if let databaseError = databaseError {
                // Present user with some error
                print(databaseError.localizedDescription)
            } else {
                self?.pokemons = pokemons!
                self?.activityIndicator.stopAnimating()
                self?.collectionView?.reloadData()
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


extension PokedexViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemons.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCell.identifier, for: indexPath) as! PokemonCell
        let pokemon = pokemons[indexPath.row]
        
        cell.tag = indexPath.row
        cell.configureCell(pokemon: pokemon)
        database.fetchPokemonPic(url: pokemon.imageURL) { (image, databaseError) in
            if let databaseError = databaseError {
                print(databaseError.localizedDescription)
            } else {
                if indexPath.row == cell.tag {
                    // Set the image of the cell
                    cell.pokemonImageView.image = image
                    cell.activityIndicator.stopAnimating()
                }
            }
        }
        
        return cell
    }
}

extension PokedexViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        var rect = view.convert(cell.contentView.frame, from: cell.contentView)
        
        let pokemonView = UIView(frame: rect)
        pokemonView.backgroundColor = .black
        view.addSubview(pokemonView)
        
        pokemonView.translatesAutoresizingMaskIntoConstraints = false
        pokemonView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 5).isActive = true
        pokemonView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -5).isActive = true
        pokemonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 5).isActive = true
        pokemonView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        pokemonView.cornerRadius = 5
        pokemonView.backgroundColor = .lightGray

        UIView.animate(withDuration: animationVC) { [weak self] in
            self?.view.layoutIfNeeded()
        }
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
