//
//  GFEmptyStateView.swift
//  GHFollowers
//
//  Created by Mahmoud Ghoneim on 6/21/21.
//

import UIKit

class GFEmptyStateView: UIView {
    
    let messageLabel  = GFTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    convenience init(message:String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure(){
        self.addSubviews(logoImageView, messageLabel)
        configureLogoImageview()
        configureMessageLabel()
    }
    
    
    private func configureMessageLabel(){
        logoImageView.image        = Images.emptyStateLogo
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let messageLabelCenterYConstant:CGFloat   =   (DeviceTypes.isiphoneSE || DeviceTypes.isiphone8Zoomed) ? -80 : -150
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: messageLabelCenterYConstant),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    
    private func configureLogoImageview(){
        messageLabel.textColor     = .secondaryLabel
        messageLabel.numberOfLines = 3
        
        let logoImageBottomAnchorConstant:CGFloat = (DeviceTypes.isiphoneSE || DeviceTypes.isiphone8Zoomed) ? 100 : 40
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: logoImageBottomAnchorConstant),
        ])
    }
    
}
