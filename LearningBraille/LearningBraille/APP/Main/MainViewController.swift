//
//  ViewController.swift
//  LearningBraille
//
//  Created by George Gomes on 09/03/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController{

    let mainViewModel = MainViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.mainViewModel.isRegistered.asObservable().subscribe{
//            let a = $0.element
//            let merda = a?.0
//
//            if let m = merda{
//                for i in m{
//                    print(i.name)
//                }
//            }
//
//            print("sera? ", merda?.count)
//        }.disposed(by: disposeBag)
        
        
       
        
    
//            self.loginViewModel.loginActionResult.asObservable().subscribe{
//
//                }.disposed(by: disposeBag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        _ = self.mainViewModel.isRegistered.subscribe(onError: { (err) in
            self.performSegue(withIdentifier: "toLogin", sender: nil)
        })
    }
    
    @IBAction func exercise(_ sender: Any) {
        performSegue(withIdentifier: "toGame", sender: nil)
    }
    
    @IBAction func unwindToMain(segue:UIStoryboardSegue) {
        
    }
    
}


