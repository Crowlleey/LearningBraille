//
//  ViewController.swift
//  LearningBraille
//
//  Created by George Gomes on 09/03/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var stBraille: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.stBraille = "Hellob asuhd AOOOOO ASIS 9"
        
        stBraille.convertToBraille()
        
        
        var i = ParseJSON()
        print("ULALA")
        i.parseJsonClass()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

