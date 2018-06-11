//
//  ResponseDelegate.swift
//  LearningBraille
//
//  Created by George Gomes on 27/05/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import UIKit

protocol AtualizeIndex{
    func update(_ index: Int)
}

protocol ResponseProtocol{
    func response(_ isValue: Bool)
}

class ResponseDelegate: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    var wordBraille: StringBraille!
    var indexWrong: Int!
    var delegate: ResponseProtocol!
    
    init(with word: String, index: Int) {
        self.wordBraille = word.convertToBraille()
        self.indexWrong = index
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wordBraille.words.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let rCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResponseCell", for: indexPath) as! ResponseCell
        rCell.index = indexPath.row + 1
        rCell.update()
        
        return rCell
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

extension ResponseDelegate: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(indexPath.row == self.indexWrong){
            delegate.response(true)
        }else{
            delegate.response(false)
        }
    }
}

extension ResponseDelegate: Atualize{
    func update(_ word: String) {
         self.wordBraille = word.convertToBraille()
    }
}

extension ResponseDelegate: AtualizeIndex{
    func update(_ index: Int) {
        self.indexWrong = index
    }
}

