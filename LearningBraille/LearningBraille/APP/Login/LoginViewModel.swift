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

class LoginViewModel {
    
    private let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let email = Variable<String>("Start With Value 2")
    let password = Variable<String>("")

    var isValidEmail: Observable<Bool> {
        let emailTest = NSPredicate(format:"SELF MATCHES %@", regex)
        return email.asObservable().map({
            emailTest.evaluate(with: $0)
        })
    }
    
    let signInDidTapSubject = PublishSubject<Void>()
    let loginActionResult: Driver<AutheticationStatus>
    
    private let disposeBag = DisposeBag()
    
    init() {
        
        let userAndPassword = Observable.combineLatest(email.asObservable(), password.asObservable()){ ($0, $1) }
        
        self.loginActionResult = signInDidTapSubject.asObservable()
            .withLatestFrom(userAndPassword)
            .flatMap{ return Authentication().rxLogin(with: $0.0, $0.1) }
            .asDriver(onErrorJustReturn: .error(.server))
    }
}
