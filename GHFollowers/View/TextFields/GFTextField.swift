//
//  GFTextField.swift
//  GHFollowers
//
//  Created by Mahmoud Ghoneim on 6/19/21.
//

import UIKit

class GFTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius        = 10
        layer.borderWidth         = 2
        layer.borderColor         = UIColor.systemGray4.cgColor
        placeholder               = "Enter a username"
        backgroundColor           = .tertiarySystemBackground
        textAlignment             = .center
        textColor                 = .label
        tintColor                 = .label
        font                      = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize           = 12
        autocorrectionType        = .no
        clearButtonMode           = .whileEditing
        returnKeyType             = .go
    }
}
