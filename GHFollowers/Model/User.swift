//
//  User.swift
//  GHFollowers
//
//  Created by Mahmoud Ghoneim on 6/19/21.
//

import Foundation

struct User: Codable{
    
    let login       : String
    let avatarUrl   : String
    let htmlUrl     : String
    let name        : String?
    let location    : String?
    let bio         : String?
    let createdAt   : String
    let publicRepos : Int
    let publicGists : Int
    let followers   : Int
    let following   : Int
    
}

