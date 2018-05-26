//
//  QuizController.swift
//  LearningBraille
//
//  Created by George Gomes on 25/05/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController{
    
    @IBOutlet weak var lbCorrectWord: UILabel!
    @IBOutlet weak var lbWrongWord: UILabel!
    
    @IBOutlet weak var cvCorrectWord: UICollectionView!
    @IBOutlet weak var cvWrongWord: UICollectionView!
    @IBOutlet weak var cvResponse: UICollectionView!
    
    var correctResponse: Int!
    var correctWord: String!
    var wrongCharacter: (key: String, value: LetterBraille)!
    var wrongCharacterIndex: Int!
    var wrongWord: String!
    
    var dataS: CorrectWordDelegate!
    
    override func viewDidLoad() {

        super.viewDidLoad()
        jumpWord()

        self.dataS =  CorrectWordDelegate(with: self.correctWord)
        self.cvCorrectWord.dataSource = dataS
    }
    
    @IBAction func btJump(_ sender: Any) {
        jumpWord()
    }
    
    func jumpWord(){
        self.correctWord = ParseJSON.sharedInstance.randomWord()
        self.wrongCharacterIndex = Int(arc4random_uniform(UInt32(correctWord.count)))
        self.wrongCharacter = ParseJSON.sharedInstance.randomCharacter()

        self.wrongWord = replace(myString: correctWord, Int(arc4random_uniform(UInt32(correctWord.count))), Character(wrongCharacter.key))
        
        self.lbCorrectWord.text = correctWord
        self.lbWrongWord.text = wrongWord
        
    }
    
    func replace(myString: String, _ index: Int, _ newChar: Character) -> String {
        var chars = Array(myString.characters)     // gets an array of characters
        chars[index] = newChar
        let modifiedString = String(chars)
        return modifiedString
    }
    
}
