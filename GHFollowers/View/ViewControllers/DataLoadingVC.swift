//
//  DataLoadingVC.swift
//  GHFollowers
//
//  Created by Mahmoud Ghoneim on 6/23/21.
//

import UIKit

class DataLoadingVC: UIViewController {

    var containerView:UIView!
    
    
    func showLoadingView(){
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.alpha           = 0
        containerView.backgroundColor = .systemBackground
        
        UIView.animate(withDuration: 0.3) { self.containerView.alpha = 0.8 }
        
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicatorView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicatorView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        activityIndicatorView.startAnimating()
    }
    
    
    func dismissLoadingView(){
        DispatchQueue.main.async { [self] in
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    
    func showEmptyStateView(with message:String , in view : UIView){
        let emptyStateView   = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }

}
