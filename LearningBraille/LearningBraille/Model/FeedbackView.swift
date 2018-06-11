//
//  FeedbackView.swift
//  LearningBraille
//
//  Created by George Gomes on 27/05/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import UIKit

class FeedbackView: UIView{
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var btOk: UIButton!
    
    func update(correct: Bool){
        if (correct) {
            self.title.text = "Resposta Correta"
            self.image.image = UIImage(named: "Correct")
            self.backgroundColor = UIColor(red: 224/255, green: 255/255, blue: 212/255, alpha: 1.0)
            self.btOk.isHidden = true

        }else{
            self.title.text = "DEU RUIM"
            self.image.image = UIImage(named: "Wrong")
            self.backgroundColor = UIColor(red: 255/255, green: 171/255, blue: 164/255, alpha: 1.0)
            self.btOk.isHidden = false
        }
    }
    
    @IBAction func btOk(_ sender: Any) {
        print("gang gang bro")
    }
}
