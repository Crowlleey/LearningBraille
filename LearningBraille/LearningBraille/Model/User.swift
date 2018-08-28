//
//  User.swift
//  LearningBraille
//
//  Created by George Gomes on 27/08/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import Foundation
import Firebase

extension User {
    func populate(with authDataResult: AuthDataResult){
        self.name = authDataResult.user.email
        self.email = authDataResult.user.email
        self.token = authDataResult.user.uid
    }
}
