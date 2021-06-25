//
//  GFButton.swift
//  GHFollowers
//
//  Created by Mahmoud Ghoneim on 6/19/21.
//

import UIKit

class GFButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   convenience init(backgroundColor:UIColor , title:String) {
        self.init(frame: .zero)
        set(backgroundColor: backgroundColor, title: title)
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius    = 10
        titleLabel?.textColor = .white
        titleLabel?.font      = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    func set(backgroundColor : UIColor , title: String){
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
}
