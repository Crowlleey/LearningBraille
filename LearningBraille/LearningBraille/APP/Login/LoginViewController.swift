//
//  LoginViewController.swift
//  LearningBraille
//
//  Created by George Gomes on 20/08/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Firebase

enum AlertType: String{
    case sucess = "Sucess"
    case fail = "Failure"
}

class LoginViewController: UIViewController{
    
    private var loginViewModel: LoginViewModel!
    private let disposeBag = DisposeBag()
    
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
    
    var text: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginViewModel = LoginViewModel()

        self.btForgotPassword.setTitle("", for: .normal)
        self.hideKeyboard()
        
        setupBindings()
    }
    
    @IBAction func btForgotPassword(_ sender: Any) {
        print(self.text)
    }
    
    @IBAction func btSignIn(_ sender: Any) {
        attempts = attempts + 1
        
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
    
    func setupBindings(){
        _ = self.tfEmail.rx.text.map{ $0 ?? "" }.bind(to: self.loginViewModel.email)
        _ = self.tfPassword.rx.text.map{ $0 ?? "" }.bind(to: self.loginViewModel.password)
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
