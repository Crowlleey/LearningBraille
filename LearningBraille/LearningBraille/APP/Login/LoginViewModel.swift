//
//  LoginViewModel.swift
//  LearningBraille
//
//  Created by George Gomes on 23/08/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import Foundation

struct LoginViewModel {
    
    var email: String!
    var password: String!
    
    func login(){
        print(email!, " email + senha ", password!)
    }
    
}
