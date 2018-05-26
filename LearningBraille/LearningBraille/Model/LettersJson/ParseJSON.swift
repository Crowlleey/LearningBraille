//
//  ParseJSON.swift
//  LearningBraille
//
//  Created by George Gomes on 17/04/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import Foundation

class ParseJSON {
    
    static let sharedInstance = ParseJSON()
    
    var letters: [String: LetterBraille] = [String: LetterBraille]()
    var numbers: [String: LetterBraille] = [String: LetterBraille]()
    var simbles: [String: LetterBraille] = [String: LetterBraille]()
    var words: [String]!
    
    private init() {
        if let path = Bundle.main.url(forResource:"Letters" , withExtension: "json"){
            do{
                let data = try Data(contentsOf: path)
                let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [Bool]]
                
                if let resultD = result{
                    letters = resultD
                }
            }catch let err{
                print(err)
            }
        }
        
        if let path = Bundle.main.url(forResource:"Numbers" , withExtension: "json"){
            do{
                let data = try Data(contentsOf: path)
                let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [Bool]]
                
                if let resultD = result{
                    numbers = resultD
                }
            }catch let err{
                print(err)
            }
        }
        
        if let path = Bundle.main.url(forResource:"Simbles" , withExtension: "json"){
            do{
                let data = try Data(contentsOf: path)
                let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [Bool]]
                
                if let resultD = result{
                    simbles = resultD
                }
            }catch let err{
                print(err)
            }
        }
        
        if let path = Bundle.main.url(forResource:"Words5Letters" , withExtension: "json"){
            do{
                let data = try Data(contentsOf: path)
                let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String]
                if let resultD = result{
                    words = resultD
                }
            }catch let err{
                print(err)
            }
        }
    }
    
    func brailleFrom(this letter: String) -> LetterBraille {
        var letterToReturn: LetterBraille!
        
        for re in letters{
            if (re.key == letter){
                letterToReturn = re.value
            }
        }
        return letterToReturn
    }
    
    func brailleFromThis (number: String) -> LetterBraille{
        var letterToReturn: LetterBraille!
        
        for re in numbers{
            if (re.key == number){
                letterToReturn = re.value
            }
        }
        return letterToReturn
    }
    
    func brailleFromThis (simble: String) -> LetterBraille{
        var letterToReturn: LetterBraille!
        
        for re in simbles{
            if (re.key == simble){
                letterToReturn = re.value
            }
        }
        return letterToReturn
    }

    func randomCharacter() -> (key: String, value: LetterBraille){
        let randomCharacter = Array(letters)[Int(arc4random_uniform(UInt32(letters.count)))]
        return randomCharacter
    }
    
    func randomWord() -> String{
        let randomWord = words[Int(arc4random_uniform(UInt32(words.count)))]
        return randomWord
    }
}
