//
//  ResponseCell.swift
//  LearningBraille
//
//  Created by George Gomes on 27/05/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import UIKit

class ResponseCell: UICollectionViewCell{
    var index: Int!
    
    @IBOutlet weak var lbResponse: UILabel!
    
    func update(){
        self.backgroundColor = .clear
        self.lbResponse.text = String(self.index)
    }
}
