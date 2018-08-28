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


