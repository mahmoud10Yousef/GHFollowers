//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by Mahmoud Ghoneim on 6/22/21.
//

import UIKit

protocol GFFollowerItemVCDelegate: class {
    func didTapGetfollowers(for user : User)
}

class GFFollowerItemVC: GFItemInfoVC {
    
    weak var delegate   : GFFollowerItemVCDelegate!
    
    
    init(user:User , delegate: GFFollowerItemVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
   
    
    func configureItems(){
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    
    override func actionButtonTapped() {
        delegate.didTapGetfollowers(for: user)
    }
    
}
