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
    var cvWrongDelegate: CorrectWordDelegate!
    var cvResponseDelegate: ResponseDelegate!
    var randomIndex: Int!
    
    
    var atualize: Atualize!
    var atualizeWrong: Atualize!
    var atualizeResponse: Atualize!
    var atualizeIndex: AtualizeIndex!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jumpWord()

        self.dataS =  CorrectWordDelegate(with: self.correctWord)
        self.cvCorrectWord.dataSource = dataS
        self.cvCorrectWord.delegate = dataS
        self.atualize = dataS
        
        self.cvWrongDelegate = CorrectWordDelegate(with: self.wrongWord)
        self.cvWrongWord.delegate = cvWrongDelegate
        self.cvWrongWord.dataSource = cvWrongDelegate
        self.atualizeWrong = cvWrongDelegate
        
        let randomIndex = Int(arc4random_uniform(UInt32(correctWord.count)))
        self.cvResponseDelegate = ResponseDelegate(with: self.wrongWord, index: randomIndex)
        self.cvResponseDelegate.delegate = self
        self.cvResponse.delegate = cvResponseDelegate
        self.cvResponse.dataSource = cvResponseDelegate
        self.atualizeResponse = cvResponseDelegate
        self.atualizeIndex = cvResponseDelegate
        
        self.cvCorrectWord.backgroundColor = .gray
    }
    
    @IBAction func btJump(_ sender: Any) {
        jumpWord()
    }
    
    func jumpWord(){
        self.correctWord = ParseJSON.sharedInstance.randomWord()
        self.wrongCharacterIndex = Int(arc4random_uniform(UInt32(correctWord.count)))
        self.wrongCharacter = ParseJSON.sharedInstance.randomCharacter()

        let randomIndex = Int(arc4random_uniform(UInt32(correctWord.count)))
        self.wrongWord = replace(myString: correctWord, randomIndex, Character(wrongCharacter.key))
        
        self.lbCorrectWord.text = correctWord
        self.lbWrongWord.text = wrongWord
        DispatchQueue.main.async {
            self.atualize.update(self.correctWord)
            self.atualizeWrong.update(self.wrongWord)
            self.atualizeResponse.update(self.wrongWord)
            self.atualizeIndex.update(randomIndex)
            self.cvCorrectWord.reloadData()
            self.cvWrongWord.reloadData()
            self.cvResponse.reloadData()
            BLEBridg.sharedInstance.sendToBLE(word: self.wrongWord.convertToBraille())
        }
    }
    
    func replace(myString: String, _ index: Int, _ newChar: Character) -> String {
        var chars = Array(myString.characters)     // gets an array of characters
        chars[index] = newChar
        let modifiedString = String(chars)
        return modifiedString
    }
}

extension QuizViewController: ResponseProtocol{
    func response(_ isValue: Bool) {
        print(isValue)
        if (isValue){
            self.jumpWord()
        }else{
            self.jumpWord()
        }
    }
}
