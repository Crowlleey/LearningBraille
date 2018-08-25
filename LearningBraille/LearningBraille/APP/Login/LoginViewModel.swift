//
//  LoginViewModel.swift
//  LearningBraille
//
//  Created by George Gomes on 23/08/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct LoginViewModel {
    
    let email = Variable<String>("Start With Value 2")
    let password = Variable<String>("")
    private let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
//    func login(){
//        print(email.value, " email + senha ", password.value)
//    }
    
    var isValidEmail: Observable<Bool> {
        let emailTest = NSPredicate(format:"SELF MATCHES %@", regex)
        return email.asObservable().map({
            emailTest.evaluate(with: $0)
        })
    }
    
    
    func login(){
        //        self.loginViewModel.login()
        //        auth.login(with: self.tfEmail.text!, self.tfPassword.text!) { (res, err) in
        //            if (err == nil) {
        //                self.createAllert(with: .sucess, message: "Welcome", action: {
        //                    let user: User = CoreDataManager.managerInstance().Object()
        //                    user.name = res?.user.email
        //                    user.email = res?.user.email
        //                    user.token = res?.user.uid
        //                    CoreDataManager.managerInstance().saveThis(user, completionHandler: { (err) in
        //                        print(err ?? "Nao tem err")
        //                    })
        //                    self.performSegue(withIdentifier: "unwindToMain", sender: nil)
        //                })
        //            }else{
        //                let message = err.debugDescription.translateFBError()
        //                self.createAllert(with: .fail, message: message!, action: nil)
        //            }
        //        }
    }

    
}
