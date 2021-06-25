//
//  FavoritesListVC.swift
//  GHFollowers
//
//  Created by Mahmoud Ghoneim on 6/18/21.
//

import UIKit

class FavoritesListVC: DataLoadingVC {
    
    let tableView            = UITableView()
    var favorites:[Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureTableView(){
        view.addSubview(tableView)
        tableView.frame           = view.bounds
        tableView.rowHeight       = 80
        tableView.delegate        = self
        tableView.dataSource      = self
        tableView.removeExcessCells()
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    
    func getFavorites(){
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                self.updateUI(with: favorites)
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue, titleButton: "OK")
            }
        }
    }
    
    
    func updateUI(with favorites:[Follower]){
        if favorites.isEmpty {
            self.showEmptyStateView(with: "NO Favorites?\nAdd one on the follower screen .", in: self.view)
        }else{
            self.favorites = favorites
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.view.bringSubviewToFront(self.tableView)
            }
        }
    }
}


extension FavoritesListVC: UITableViewDelegate , UITableViewDataSource{
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID, for: indexPath) as! FavoriteCell
        cell.set(favorite: favorites[indexPath.row])
        return cell
    }
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let favorite    = favorites[indexPath.row]
        let destVC      = FollowerListVC(username: favorite.login)
        self.navigationController?.pushViewController(destVC, animated: true)
    }
    
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }
     
        PersistenceManager.updateWith(favorite: favorites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self = self else   { return }
            
            guard let error = error else {
                self.favorites.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            self.presentAlertOnMainThread(title: "Unable to remove", message: error.rawValue, titleButton: "OK")
        }
    }
}
