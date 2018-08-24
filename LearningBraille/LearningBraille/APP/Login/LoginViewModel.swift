//
//  LoginViewModel.swift
//  LearningBraille
//
//  Created by George Gomes on 23/08/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import Foundation
import RxSwift

struct LoginViewModel {
    
    let email = Variable<String>("Start With Value 2")
    let password = Variable<String>("")
    private let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    func login(){
        print(email.value, " email + senha ", password.value)
    }
    
    var isValidEmail: Observable<Bool> {
        let emailTest = NSPredicate(format:"SELF MATCHES %@", regex)
        return email.asObservable().map({
            emailTest.evaluate(with: $0)
        })
    }

    
}
