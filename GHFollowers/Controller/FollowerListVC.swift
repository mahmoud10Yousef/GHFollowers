//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Mahmoud Ghoneim on 6/19/21.
//

import UIKit

class FollowerListVC: DataLoadingVC{
    
    enum Section{ case main }
    
    var username :String!
    var followers:[Follower]         = []
    var filteredFollowers:[Follower] = []
    var page                         = 1
    var hasMoreFollowers             = true
    var isSearching                  = false
    var isLoadingMoreFollowers       = false
    
    var collectionView : UICollectionView!
    var dataSource     : UICollectionViewDiffableDataSource<Section , Follower>!
    
    
    init(username:String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        self.title    = username
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        fetchFollowers(username: username, page: page)
        configureDataSource()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    
    func configureSearchController(){
        let searchController                                  = UISearchController()
        searchController.searchResultsUpdater                 = self
        searchController.searchBar.placeholder                = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController                       = searchController
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate        = self
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    
    func fetchFollowers(username:String , page: Int){
        self.showLoadingView()
        isLoadingMoreFollowers = true
        
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            
            self.dismissLoadingView()
            
            switch result{
            case .success(let followers):
                self.updateUI(with: followers)
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Bad Stuff Happened", message: error.rawValue , titleButton: "OK")
            }
            self.isLoadingMoreFollowers = false
        }
    }
    
    
    func updateUI(with followers:[Follower]){
        if followers.count < 100 { self.hasMoreFollowers = false }
        self.followers.append(contentsOf: followers)
        
        if self.followers.isEmpty{
            let message = "This user doesn't have any followers. Go follow them 😀."
            DispatchQueue.main.async { self.showEmptyStateView(with: message , in: self.view) }
            return
        }
        self.updateData(on: self.followers)
    }
    
    
    func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    
    func updateData(on followers: [Follower]){
        var snapShot = NSDiffableDataSourceSnapshot<Section , Follower>()
        snapShot.appendSections([.main])
        snapShot.appendItems(followers)
        DispatchQueue.main.async { self.dataSource.apply(snapShot, animatingDifferences: true) }
    }
    
    
    @objc func addButtonTapped(){
        showLoadingView()
        NetworkManager.shared.getUserInfo(for: username) {[weak self] result in
        
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result{
            case .success(let user):
                self.saveUserToFavorites(user: user)
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something Went wrong", message: error.rawValue, titleButton: "OK")
            }
        }
    }
    
    
    func saveUserToFavorites(user: User){
        let follower = Follower(login: user.login, avatarUrl: user.avatarUrl)
        
        PersistenceManager.updateWith(favorite: follower, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else {
                self.presentAlertOnMainThread(title: "Success!", message: "You have successfully favorited this user 🎉", titleButton: "Hooray!")
                return
            }
            self.presentAlertOnMainThread(title: "Something Went wrong", message: error.rawValue, titleButton: "OK")
        }
    }
}


extension FollowerListVC: UICollectionViewDelegate{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offsetY       = scrollView.contentOffset.y
        let height        = scrollView.frame.size.height
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - height{
            guard hasMoreFollowers , !isLoadingMoreFollowers else { return }
            page += 1
            fetchFollowers(username: username, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedItem = isSearching ? filteredFollowers[indexPath.item] : followers[indexPath.item]
        
        let destVC       = UserInfoVC(username: selectedItem.login, delegate: self)
        let nav          = UINavigationController(rootViewController: destVC)
        present(nav, animated: true, completion: nil)
    }
}

extension FollowerListVC: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter  = searchController.searchBar.text , !filter.isEmpty else {
            isSearching = false
            filteredFollowers.removeAll()
            updateData(on: self.followers)
            return
        }
        isSearching       = true
        filteredFollowers = self.followers.filter({  $0.login.lowercased().contains(filter.lowercased()) })
        updateData(on: filteredFollowers)
    }
    
}

extension FollowerListVC: UserInfoVCDelegate{
    func didRequestFollower(for username: String) {
        page          = 1
        self.username = username
        self.title    = username
        filteredFollowers.removeAll()
        followers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        fetchFollowers(username: username, page: page)
    }
}
