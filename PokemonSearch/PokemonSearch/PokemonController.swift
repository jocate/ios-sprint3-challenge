//
//  PokemonController.swift
//  PokemonSearch
//
//  Created by Jocelyn Stuart on 1/25/19.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation


class PokemonController {
    
    var pokemons: [Pokemon] = []
    
    static var baseURL = URL(string: "https://pokeapi.co/api/v2/pokemon/")! //{id or name}/
    
    
    func searchForPokemon(with searchTerm: String, completion: @escaping (Pokemon?, Error?) -> Void) {
     
        let url = PokemonController.baseURL.appendingPathComponent(searchTerm.lowercased())
        
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                NSLog("Error fetching data: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("Error fetching data. No data returned.")
                completion(nil, NSError())
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                //jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let pokemon = try jsonDecoder.decode(Pokemon.self, from: data)
                //let pokemons = Array(searchResults.values)
               // self.pokemons = pokemons
                completion(pokemon, nil)
            } catch {
                NSLog("Unable to decode data into people: \(error)")
                completion(nil, error)
                return
            }
            
        }
        dataTask.resume()
        
    }
    
    func addPokemon(pokemon: Pokemon) {
        pokemons.append(pokemon)
    }
   /* func create(withName name: String, and id: Int, andAbility abilities: [Pokemon.AbilityHelp], andType types: [Pokemon.TypeHelp], completion: @escaping (Error?) -> Void) {
        let pokemon = Pokemon(name: name, id: id, abilities: abilities, types: types)
        pokemons.append(pokemon)
        
    }*/
    
    func delete(pokemon: Pokemon) {
        guard let index = self.pokemons.index(of: pokemon) else {return}
        pokemons.remove(at: index)
    }
    
    
}
