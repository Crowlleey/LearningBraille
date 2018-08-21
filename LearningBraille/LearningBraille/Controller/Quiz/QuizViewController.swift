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
    
    @IBOutlet var vwFeedBack: FeedbackView!
    
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

        
//        yourCollectionView.contentInset = UIEdgeInsets(top: 0, left: yourCollectionView.width/2, bottom: 0, right: 0)
//        self.cvCorrectWord.contentInset = UIEdgeInsets(top: 0, left: self.cvCorrectWord.frame.width/1.7, bottom: 0, right: 0)
//        self.cvWrongWord.contentInset = UIEdgeInsets(top: 0, left: self.cvWrongWord.frame.width/1.7, bottom: 0, right: 0)
//        self.cvResponse.contentInset = UIEdgeInsets(top: 0, left: self.cvResponse.frame.width/1.7, bottom: 0, right: 0)

//        self.cvCorrectWord.contentOffset = CGPoint(x: 500, y: 0)
   
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        self.cvCorrectWord.setContentOffset(CGPoint(x: (self.view.frame.width / 4) * -1 , y: 0), animated: true)
//        self.cvWrongWord.setContentOffset(CGPoint(x: (self.view.frame.width / 4) * -1 , y: 0), animated: true)
//        self.cvResponse.setContentOffset(CGPoint(x: (self.view.frame.width / 4) * -1 , y: 0), animated: true)
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
        let midX = self.view.frame.midX
        let midY = self.view.frame.midY
        let frame = self.view.frame
        let viewPositionX = midX - midX / 1.5
        let viewPositionY = midY - midY / 2
        
        let blurEffect = UIBlurEffect(style:.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        vwFeedBack.frame = CGRect(x: viewPositionX, y: viewPositionY, width: frame.width / 1.5, height: frame.height / 2)
        vwFeedBack.update(correct: isValue)
        print(isValue)
        
        vwFeedBack.alpha = 0
        blurEffectView.alpha = 0
        
        UIView.animate(withDuration: 0.5, animations: {
            self.vwFeedBack.alpha = 1.0
            blurEffectView.alpha = 1.0
        })

        self.view.addSubview(blurEffectView)
        
        self.view.addSubview(vwFeedBack)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            UIView.animate(withDuration: 0.5, animations: {
                self.vwFeedBack.alpha = 0
                blurEffectView.alpha = 0
                self.jumpWord()
            })
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.animate(withDuration: 0.5, animations: {
                blurEffectView.removeFromSuperview()
                self.vwFeedBack.removeFromSuperview()
            })
        }
    }
}
