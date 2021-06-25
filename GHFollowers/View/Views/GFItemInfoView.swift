//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by Mahmoud Ghoneim on 6/21/21.
//

import UIKit

enum ItemInfoType{
    case repos , gists , following , followers
}

class GFItemInfoView: UIView {
    
    let symbolImageView = UIImageView()
    let titleLabel      = GFTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel      = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        addSubviews(symbolImageView , titleLabel , countLabel)
        
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor   = .label
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor , constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    
    func set(itemInfoType : ItemInfoType , withCount count: Int){
        switch itemInfoType {
        case .repos:
            titleLabel.text       = "Public Repos"
            symbolImageView.image = SFSymbols.repos
        case .gists:
            titleLabel.text       = "Public Gists"
            symbolImageView.image =  SFSymbols.gists
        case .following:
            titleLabel.text       = "Following"
            symbolImageView.image = SFSymbols.following
        case .followers:
            titleLabel.text       = "Followers"
            symbolImageView.image = SFSymbols.follower
        }
        countLabel.text = String (count)
    }
    
}
