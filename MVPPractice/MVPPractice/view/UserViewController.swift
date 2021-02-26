 //
//  ViewController.swift
//  MVPPractice
//
//  Created by Pasonatech on 2021/02/25.
//

import UIKit

 class UserViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    private let userPresenter = UserPresenter(userService: UserService())
    private var userToDisplay = [UserViewData]()
    
    private let cellIdentifier = "UserCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        activityIndicator.hidesWhenStopped = true
        
        userPresenter.attachView(view: self)
        userPresenter.getUsers()
    }
}
 extension UserViewController : UserView {
    func startLoading() {
        activityIndicator.startAnimating()
    }
    func finishLoading() {
        activityIndicator.stopAnimating()
    }
    func setEmptyUsers() {
        tableView.isHidden = true
    }
    func setUsers(users: [UserViewData]) {
        userToDisplay = users
        tableView.isHidden = false
        tableView.reloadData()
    }
 }

extension UserViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let userViewData = userToDisplay[indexPath.row]
        cell.textLabel?.text = userViewData.name
        cell.detailTextLabel?.text = userViewData.age
        
        return cell
    }
    
    
}
