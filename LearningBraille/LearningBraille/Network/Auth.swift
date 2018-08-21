//
//  Auth.swift
//  LearningBraille
//
//  Created by George Gomes on 20/08/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class Authentication{
    
    var ref: DatabaseReference!
    
    init() {
        ref = Database.database().reference()
    }
    
    func createUser(with email: String, _ password: String, completion: @escaping (AuthDataResult?, Error?) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
            completion(res, err)
        }
    }
    
    func login(with email: String,_ password: String, completion: @escaping (AuthDataResult?, Error?) -> Void){
        Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
            completion(res, err)
        }
//
//        Auth.auth().signIn(withEmail: "giorgines@gmail.com", password: "agoravai") { (res, err) in
//            completion(res, err)
//        }
    }
}
