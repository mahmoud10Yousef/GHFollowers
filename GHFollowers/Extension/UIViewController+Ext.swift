//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by Mahmoud Ghoneim on 6/19/21.
//

import UIKit
import SafariServices

extension UIViewController{
    
    func presentAlertOnMainThread(title:String , message:String , titleButton:String){
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(alertTitle: title , message: message, titleButton: titleButton)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle   = .crossDissolve
            self.present(alertVC, animated: true, completion: nil)
        }
    }
    
    func presentSafariVC(with url : URL) {
        let safariVC                       = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }

}
