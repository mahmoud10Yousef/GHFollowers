//
//  GFAlertVC.swift
//  GHFollowers
//
//  Created by Mahmoud Ghoneim on 6/19/21.
//

import UIKit

class GFAlertVC: UIViewController {
    
    let containerView = GFAlertView(frame: .zero)
    let titleLabel    = GFTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel  = GFBodyLabel(textAlignment: .center)
    let actionButton  = GFButton(backgroundColor: .systemPink, title: "OK")
    
    var alertTitle  : String?
    var message     : String?
    var titleButton : String?
    
    let padding     :CGFloat = 20
    
    
    init(alertTitle:String , message:String , titleButton: String ){
        super.init(nibName: nil, bundle: nil)
        self.alertTitle  = alertTitle
        self.message     = message
        self.titleButton = titleButton
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addSubviews(containerView , titleLabel , messageLabel , actionButton)
        
        configureContainerView()
        configureAlertTitle()
        configureActionButton()
        configureMessageLabel()
    }
    
    
    func configureContainerView(){
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor) ,
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor) ,
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    
    func configureAlertTitle(){
        titleLabel.text = alertTitle ?? "Something went wrong"
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding) ,
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding) ,
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    
    func configureMessageLabel(){
        messageLabel.text          = message ?? "Unable to complete request"
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8) ,
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding) ,
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        ])
    }
    
    
    func configureActionButton(){
        actionButton.setTitle(titleButton ?? "OK" , for: .normal)
        actionButton.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding) ,
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding) ,
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding) ,
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    
    @objc func dismissAlert(){
        dismiss(animated: true)
    }
}
