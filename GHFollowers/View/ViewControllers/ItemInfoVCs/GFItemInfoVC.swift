//
//  GFItemInfoVC.swift
//  GHFollowers
//
//  Created by Mahmoud Ghoneim on 6/21/21.
//

import UIKit


class GFItemInfoVC: UIViewController {
    
    let itemInfoViewOne = GFItemInfoView()
    let itemInfoViewTwo = GFItemInfoView()
    let actionButton    = GFButton()
    let stackView       = UIStackView()
    
    var user:User!
    
    
    init(user:User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBacgroundView()
        layoutUI()
        configureActionButton()
    }
    
    
    private func configureBacgroundView(){
        view.layer.cornerRadius  = 18
        view.backgroundColor     = .secondarySystemBackground
    }
    
   
    func  configureActionButton(){
      actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    
    @objc func actionButtonTapped() {  }
    
    
    private func layoutUI(){
        let padding:CGFloat = 20
        
        view.addSubviews(stackView , actionButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        stackView.axis         = .horizontal
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)
        
    }
    
}
