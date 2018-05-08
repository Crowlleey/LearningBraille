//
//  ParseJSON.swift
//  LearningBraille
//
//  Created by George Gomes on 17/04/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import Foundation

class ParseJSON {
    
    var objFromJson: [String: LetterBraille] = [String: LetterBraille]()
    
    
func parseJsonClass(){
        if let path = Bundle.main.url(forResource:"Letters" , withExtension: "json"){
            do{
                let data = try Data(contentsOf: path)
//                self.objFromJson = try JSONDecoder().decode([String: Any].self, from: data)
                let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String: [Bool]]
                if let resultD = result{
                    for re in resultD{
                        var letterBraille = LetterBraille(
                    }
                }
                
            }catch let err{

                print(err)
            }
        }
    
    if let path = Bundle.main.url(forResource:"Names" , withExtension: "json"){
        do{
            let data = try Data(contentsOf: path)
            var i = try JSONSerialization.jsonObject(with: data, options: []) as? [String: (String, String)]
            print(i)
            
        }catch let err{
            
            print(err)
        }
    }
    
    
    
    
    }
}
