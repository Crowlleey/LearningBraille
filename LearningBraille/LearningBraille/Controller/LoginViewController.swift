//
//  LoginViewController.swift
//  LearningBraille
//
//  Created by George Gomes on 20/08/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController{
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btForgotPassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btForgotPassword.setTitle("", for: .normal)
    
    }
    
    @IBAction func btForgotPassword(_ sender: Any) {
    
    }
    
    @IBAction func btSignIn(_ sender: Any) {
        
    }
    
    @IBAction func btCreateAcc(_ sender: Any) {
        
    }
    
}
