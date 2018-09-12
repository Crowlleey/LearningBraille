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
import Rswift

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
    @IBOutlet weak var btSignIn: UIButton!
    @IBOutlet weak var btCreateAccount: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginViewModel = LoginViewModel()

        self.btForgotPassword.setTitle("", for: .normal)
        self.hideKeyboard()
        
        setupBindings()

        self.btSignIn.setTitle(R.string.localizable.sign_IN() , for: .normal)
        self.btCreateAccount.setTitle(R.string.localizable.create_NEW_USER(), for: .normal)
        
    }
    
    // Mark: - Setup bindings
    
    func setupBindings(){
        // setup tex field bildings (send to login view-model when tfEmail and tfPassword change text)
        _ = self.tfEmail.rx.text.map{ $0 ?? "" }.bind(to: self.loginViewModel.email)
        _ = self.tfPassword.rx.text.map{ $0 ?? "" }.bind(to: self.loginViewModel.password)

        // setup button bindig (send to login view-model when btSignIn is pressed)
        self.btSignIn.rx.tap
            .bind(to: self.loginViewModel.signInDidTapSubject)
            .disposed(by: self.disposeBag);
        
        // observing the result of the call when the button is pressed
        _ = self.loginViewModel.loginActionResult.asObservable().subscribe(onNext: { [unowned self] response in
            switch response{
            case .error(_):
                self.createAllert(with: .fail, message: "Falha ao logar", action: nil)
            case .success(let dataResult):
                let usr: User = CoreDataManager.managerInstance().Object()
                usr.populate(with: dataResult)
                CoreDataManager.managerInstance().saveThis(usr)
                self.createAllert(with: .sucess, message: "Logado com sucesso", action: {
                    self.performSegue(withIdentifier: "unwindToMain", sender: nil)
                })
            }
        })
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
