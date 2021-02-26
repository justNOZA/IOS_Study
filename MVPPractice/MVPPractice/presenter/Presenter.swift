//
//  Pretender.swift
//  MVPPractice
//
//  Created by Pasonatech on 2021/02/25.
//

import Foundation

class UserPresenter {
    private let userService : UserService
    private weak var userView: UserView?
    
    init(userService: UserService) {
        self.userService = userService
    }
    
    func attachView(view: UserView){
        userView = view
    }
    
    func detachView(){
        userView = nil
    }
    
    func getUsers() {
        userView?.startLoading()
        userService.getUsers{ [weak self] users in
            DispatchQueue.main.async{
                self?.userView?.finishLoading()
            }
            
            guard !users.isEmpty else{
                DispatchQueue.main.async {
                    self?.userView?.setEmptyUsers()
                }
                return
            }
            
            let userViewDatas = users.map {
                UserViewData(name: "\($0.firstName)", age: "\($0.age) years")
            }
            DispatchQueue.main.async {
                self?.userView?.setUsers(users: userViewDatas)
            }
        }
        
    }
}
