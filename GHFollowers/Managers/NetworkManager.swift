//
//  NetworkManager.swift
//  GHFollowers
//
//  Created by Mahmoud Ghoneim on 6/20/21.
//

import UIKit

class NetworkManager{
    
    static let shared   = NetworkManager()
    let cache           = NSCache<NSString , UIImage>()
    private let baseURL = "https://api.github.com/users/"
    
    
    func getFollowers(for username:String , page : Int , completed: @escaping(Result<[Follower] , ErrorMessage>) -> Void ){
        let endPoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
                
            }catch{
                completed(.failure(.invalidData))
            }
            
        }).resume()
    }
    
    
    func getUserInfo(for username:String ,  completed: @escaping(Result<User , ErrorMessage>) -> Void ){
        let endPoint = baseURL + "\(username)"
        
        guard let url = URL(string: endPoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse , response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
                
            }catch{
                completed(.failure(.invalidData))
            }
            
        }).resume()
    }
    
    
    func downloadImage(from url : String , completed: @escaping(UIImage?) -> Void){
        let cacheKey = NSString(string: url)
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: url) else {
            completed(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { [weak self] data, response, error in
            
            guard let self = self ,
                  error == nil ,
                  let response = response as? HTTPURLResponse ,
                  response.statusCode == 200 ,
                  let  data = data ,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }).resume()
    }
}



