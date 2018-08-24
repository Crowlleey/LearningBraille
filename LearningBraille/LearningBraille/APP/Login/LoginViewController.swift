//
//  LoginViewController.swift
//  LearningBraille
//
//  Created by George Gomes on 20/08/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import UIKit
import Firebase

enum AlertType: String{
    case sucess = "Sucess"
    case fail = "Failure"
}

class LoginViewController: UIViewController{
    
    private var loginViewModel: LoginViewModel!
    
    @IBOutlet weak var tfEmail: BindingTextField! {
        didSet{
            tfEmail.bind{ self.loginViewModel.email.value = $0 }
        }
    }
    
    @IBOutlet weak var tfPassword: BindingTextField! {
        didSet{
            tfPassword.bind{ self.loginViewModel.password.value = $0 }
        }
    }
    
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
    
    var text: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginViewModel = LoginViewModel()

        self.loginViewModel.email.bind{ self.text = $0 }
        
        self.btForgotPassword.setTitle("", for: .normal)
        self.hideKeyboard()
    }
    
    @IBAction func btForgotPassword(_ sender: Any) {
        print(self.text)
    }
    
    @IBAction func btSignIn(_ sender: Any) {
        attempts = attempts + 1
        
        self.loginViewModel.login()
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
    
    var i: AuthDataResult!
    var errrr: Error!

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
    
    func createAllert(with type:AlertType,  message: String, action: (()-> Void)?) {
        let alert = UIAlertController(title: type.rawValue, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (aler) in
            if let act = action{
                act()
            }
        }))
         self.present(alert, animated: true, completion: nil)
    }
}

extension LoginViewController {
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
