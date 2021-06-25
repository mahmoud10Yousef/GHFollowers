//
//  PersistenceManager.swift
//  GHFollowers
//
//  Created by Mahmoud Ghoneim on 6/22/21.
//

import Foundation

enum PersistenceActionType{
    case add , remove
}

enum PersistenceManager {
    
    private static let defaults = UserDefaults.standard
    enum Keys { static let favorites = "favorites" }
    
    static func updateWith(favorite:Follower , actionType: PersistenceActionType , completion: @escaping(ErrorMessage?) ->Void ){
        retrieveFavorites { result in
            switch result{
            
            case .success(var favorites):
                
                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {
                        completion(.alreadyInFavorites)
                        return
                    }
                    favorites.append(favorite)
                    
                case .remove:
                    favorites.removeAll {  $0.login == favorite.login  }
                }
                completion(save(favorites: favorites))
                
            case.failure(let error):
                completion(error)
            }
        }
    }
    
    
    static func retrieveFavorites(completion: @escaping( Result<[Follower] , ErrorMessage> )-> Void){
        guard let favoriteseData = defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            return
        }
        
        do{
            let favorites = try JSONDecoder().decode([Follower].self, from: favoriteseData)
            completion(.success(favorites))
            
        }catch{
            completion(.failure(.unableToFavorite))
        }
    }
    
    
    
    static func save(favorites:[Follower]) -> ErrorMessage? {
        do{
            let encodedFavorites = try JSONEncoder().encode(favorites)
            defaults.setValue(encodedFavorites, forKey: Keys.favorites)
            return nil
        }catch{
            return .unableToFavorite
        }
    }
    
}
