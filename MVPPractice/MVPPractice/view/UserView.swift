//
//  UserView.swift
//  MVPPractice
//
//  Created by Pasonatech on 2021/02/25.
//

import Foundation

protocol UserView : class{
    func startLoading()
    func finishLoading()
    func setUsers(users: [UserViewData])
    func setEmptyUsers()
}
