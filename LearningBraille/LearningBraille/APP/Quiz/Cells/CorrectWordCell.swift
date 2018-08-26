//
//  CorrectWordCell.swift
//  LearningBraille
//
//  Created by George Gomes on 25/05/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import UIKit

class CorrectWordCell: UICollectionViewCell {
    
    var letter: LetterBraille!
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view5: UIView!
    @IBOutlet weak var view6: UIView!
    
    func update(){
        
        self.layer.borderColor = UIColor.black.cgColor
        refresh()
        if(letter[0]){self.view1.backgroundColor = .black}
        if(letter[1]){self.view2.backgroundColor = .black}
        if(letter[2]){self.view3.backgroundColor = .black}
        if(letter[3]){self.view4.backgroundColor = .black}
        if(letter[4]){self.view5.backgroundColor = .black}
        if(letter[5]){self.view6.backgroundColor = .black}
    }
    
    func refresh(){
        self.view1.backgroundColor = .clear
        self.view2.backgroundColor = .clear
        self.view3.backgroundColor = .clear
        self.view4.backgroundColor = .clear
        self.view5.backgroundColor = .clear
        self.view6.backgroundColor = .clear
    }
}
