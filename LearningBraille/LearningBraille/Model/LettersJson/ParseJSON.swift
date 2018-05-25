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
    private init() { }

    func brailleFrom(this letter: String) -> LetterBraille{
        var letters: [String: LetterBraille] = [String: LetterBraille]()
        var letterToReturn: LetterBraille!
        
        if let path = Bundle.main.url(forResource:"Letters" , withExtension: "json"){
            do{
                let data = try Data(contentsOf: path)
                let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [Bool]]
                
                if let resultD = result{
                   letters = resultD
                    
                    for re in letters{
                        if (re.key == letter){
                            letterToReturn = re.value
                        }
                    }
                }
            }catch let err{
                print(err)
            }
        }
     return letterToReturn
    }
}
