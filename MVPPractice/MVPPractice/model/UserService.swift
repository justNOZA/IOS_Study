//
//  UserService.swift
//  MVPPractice
//
//  Created by Pasonatech on 2021/02/25.
//
import Foundation

class UserService {
    func getUsers(completionHandler: @escaping ([User]) -> Void) {
        let users = [
            User(firstName: "alpha", lastName: "Aa", email: "Aalpha@pasona.tech", age: 21),
            User(firstName: "beta", lastName: "Bb", email: "Bbeta@pasona.tech", age: 22),
            User(firstName: "gamma", lastName: "Cc", email: "CcGamma@pasona.tech", age: 23)
            ]
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2.0){
            completionHandler(users)
        }
    }
}
