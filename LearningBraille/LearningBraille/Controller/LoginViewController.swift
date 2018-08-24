//
//  LoginViewController.swift
//  LearningBraille
//
//  Created by George Gomes on 20/08/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import UIKit

enum AlertType: String{
    case sucess = "Sucess"
    case fail = "Failure"
}

class LoginViewController: UIViewController{
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btForgotPassword: UIButton!
    
    private let auth: Authentication = {
       return Authentication()
    }()
    
    var attempts: Int = 0 {
        didSet{
            if attempts >= 3{
                self.btForgotPassword.setTitle("forgot your password?", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btForgotPassword.setTitle("", for: .normal)
        self.hideKeyboard()
    }
    
    @IBAction func btForgotPassword(_ sender: Any) {
    
    }
    
    @IBAction func btSignIn(_ sender: Any) {
        attempts = attempts + 1
        
        auth.login(with: self.tfEmail.text!, self.tfPassword.text!) { (res, err) in
            if (err == nil) {
                self.createAllert(with: .sucess, message: "Welcome", action: {
                    self.navigationController?.popViewController(animated: true)
                })
            }else{
                let message = err.debugDescription.translateFBError()
                self.createAllert(with: .fail, message: message!, action: {
//                    self.tfEmail.text = ""
//                    self.tfPassword.text = ""
                })
            }
        }
    }
    
    @IBAction func btCreateAcc(_ sender: Any) {
        auth.createUser(with: self.tfEmail.text!, self.tfPassword.text!) { (res, err) in
            if (err == nil) {
                self.createAllert(with: .sucess, message: "User created successfully", action: {
                    self.performSegue(withIdentifier: "unwindToMain", sender: nil)
                })
            }else{
                let message = err.debugDescription.translateFBError()
                self.createAllert(with: .fail, message: message!, action: {
                    self.tfEmail.text = ""
                    self.tfPassword.text = ""
                })
            }
        }
    }
    
    func createAllert(with type:AlertType,  message: String, action: @escaping ()-> Void) {
        let alert = UIAlertController(title: type.rawValue, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (aler) in
            action()
        }))
         self.present(alert, animated: true, completion: nil)
    }
    
    
}

extension LoginViewController{
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
    
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}

extension String {
    func translateFBError() -> String! {
        
        return (range(of: "\"")?.upperBound).flatMap { substringFrom in
            (range(of: "\"", range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
}
