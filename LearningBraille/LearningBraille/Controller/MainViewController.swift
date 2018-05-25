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
        
        stBraille = "GEORGE"
     
        let sttt = stBraille.convertToBraille()
        
        for words in sttt.words{
            print(words)
        }
        
    }


}


