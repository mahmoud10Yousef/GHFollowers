//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Mahmoud Ghoneim on 6/21/21.
//

import UIKit
import SafariServices

protocol UserInfoVCDelegate: class {
    func didRequestFollower(for username:String)
}

class UserInfoVC: DataLoadingVC {
    
    let scrollView  = UIScrollView()
    let contentView = UIView()
    
    let headerView  = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel   = GFBodyLabel(textAlignment: .center)
    var itemViews   = [UIView]()
    
    var  username     : String!
    weak var delegate : UserInfoVCDelegate!
    
    
    init(username:String , delegate: UserInfoVCDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        self.delegate = delegate
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureScrollView()
        layoutUI()
        getUserInfo()
    }
    
    
    func configureViewController(){
        view.backgroundColor              = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
    }
    
    
    func configureScrollView(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.heightAnchor.constraint(equalToConstant: 600),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    
    func getUserInfo(){
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else {return}
            switch result{
            
            case .success(let user):
                DispatchQueue.main.async {self.configureUIElements(for: user)}
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue, titleButton: "OK")
            }
        }
    }
    
    
    func configureUIElements(for user:User){
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: GFRepoItemVC(user: user, delegate: self) , to: self.itemViewOne)
        self.add(childVC: GFFollowerItemVC(user: user, delegate: self), to: self.itemViewTwo)
        self.dateLabel.text = "GitHub Since \(user.createdAt.convertToDisplayFormat())"
    }
    
    
    @objc func dismissVC(){
        dismiss(animated: true, completion: nil)
    }
    
    
    func layoutUI(){
        let padding:CGFloat        = 20
        let itemViewHeight:CGFloat = 140
        
        itemViews = [headerView , itemViewOne , itemViewTwo , dateLabel]
        for itemView in itemViews{
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor ,constant: -padding),
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor , constant: padding),
            ])
        }
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor , constant: padding),
            headerView.heightAnchor.constraint(equalToConstant: 200) ,
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemViewHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemViewHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 30)
            
        ])
    }
    
    
    func add(childVC: UIViewController , to containerView:UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
}


extension UserInfoVC: GFRepoItemVCDelegate , GFFollowerItemVCDelegate{
    
    func didTapGitHupProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            self.presentAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid.", titleButton: "OK")
            return
        }
        presentSafariVC(with: url)
    }
    
    
    func didTapGetfollowers(for user: User) {
        guard user.followers != 0 else {
            presentAlertOnMainThread(title: "No Followers", message: "This User has no followers. What a shame 😞.", titleButton: "So Sad")
            return
        }
        delegate.didRequestFollower(for: user.login)
        dismissVC()
    }
    
}
