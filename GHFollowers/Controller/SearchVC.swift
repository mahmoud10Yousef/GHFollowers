//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Mahmoud Ghoneim on 6/18/21.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView      = UIImageView()
    let usernameTextField  = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")

    var isUsernameEntered:Bool{
        return !usernameTextField.text!.trimmingCharacters(in: .whitespaces).isEmpty
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(logoImageView , usernameTextField , callToActionButton)
        
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameTextField.text  = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    func createDismissKeyboardTapGesture(){
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    
    func configureLogoImageView(){
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.ghLogo
        
        let logoTopConstraint:CGFloat = (DeviceTypes.isiphoneSE || DeviceTypes.isiphone8Zoomed) ? 20 : 80
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: logoTopConstraint),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    func configureTextField(){
        usernameTextField.delegate = self
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func configureCallToActionButton() {
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
   @objc func pushFollowerListVC(){
        guard isUsernameEntered else {
            presentAlertOnMainThread(title: "Empty username", message: "Please enter a username . we need to know who to look for 😀.", titleButton: "OK")
            return
        }
        usernameTextField.resignFirstResponder()
        let vc = FollowerListVC(username: usernameTextField.text!)
        navigationController?.pushViewController(vc, animated: true)
    }
}


extension SearchVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}

