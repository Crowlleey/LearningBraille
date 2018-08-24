//
//  LoginViewModel.swift
//  LearningBraille
//
//  Created by George Gomes on 23/08/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import Foundation

struct LoginViewModel {
    
    let email = Variable<String>("Start With Value 2")
    let password = Variable<String>("")
    
    func login(){
        print(email.value, " email + senha ", password.value)
    }
    
}
