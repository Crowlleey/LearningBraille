//
//  ViewController.swift
//  LearningBraille
//
//  Created by George Gomes on 09/03/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import UIKit
import CoreBluetooth

class MainViewController: UIViewController{

    var stBraille: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stBraille = "?a"
     
        let sttt = stBraille.convertToBraille()
        
//        for words in sttt.words{
//            if(words == [false,false,false,false,false,false,]){
//                print("")
//                print("")
//            }else{
//                print(words)
//            }
//        }
        
    }
    
    @IBAction func exercise(_ sender: Any) {
        performSegue(withIdentifier: "toGame", sender: nil)
    }
    
}


