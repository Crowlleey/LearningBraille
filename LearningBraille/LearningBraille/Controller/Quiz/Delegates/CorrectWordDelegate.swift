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

class CorrectWordDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
 
    var wordBraille: StringBraille!
    
    init(with word: String) {
        self.wordBraille = word.convertToBraille()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.wordBraille.words.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let wCell = collectionView.dequeueReusableCell(withReuseIdentifier: "brailleCorrect", for: indexPath) as! CorrectWordCell
        
        wCell.letter = wordBraille.words[indexPath.row]
        wCell.update()
        return wCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 60, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

        let CellWidth = collectionView.frame.width / CGFloat(collectionView.numberOfItems(inSection: 0))
        let CellCount = CGFloat(collectionView.numberOfItems(inSection: 0))
        let totalCellWidth = CellWidth * CellCount
        let CellSpacing: CGFloat = 1
        let totalSpacingWidth = CellSpacing * (CellCount - 1)

        let leftInset = (collectionView.frame.width  - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset

        return UIEdgeInsetsMake(0, leftInset, 0, rightInset)
    }

}

extension CorrectWordDelegate: Atualize{
    func update(_ word: String) {
        self.wordBraille = word.convertToBraille()
    }
}
