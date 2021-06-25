//
//  UItableView+Ext.swift
//  GHFollowers
//
//  Created by Mahmoud Ghoneim on 6/24/21.
//

import UIKit

extension UITableView{
     
    func removeExcessCells(){
        tableFooterView = UIView(frame: .zero)
    }
    
    func reloadDataOnMainThread(){
        DispatchQueue.main.async { self.reloadData() }
    }
}
