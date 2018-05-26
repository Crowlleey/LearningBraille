//
//  CorrectWordDelegate.swift
//  LearningBraille
//
//  Created by George Gomes on 25/05/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import UIKit

protocol Atualize{
    func update(_ word: String)
}

class CorrectWordDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegate{
 
    var word: String!
    
    init(with word: String) {
        self.word = word
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.word.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let wCell = collectionView.dequeueReusableCell(withReuseIdentifier: "brailleCorrect", for: indexPath) as! CorrectWordCell
        
        var letterB = word.convertToBraille()
        
        wCell.letter = letterB.words[indexPath.row]
        wCell.update()
        return wCell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
//        return CGSize(collectionView.frame.size.width, collectionView.frame.size.height)
    }
}

extension CorrectWordDelegate: Atualize{
    func update(_ word: String) {
        self.word = word
    }
}
