//
//  BLEBridg.swift
//  LearningBraille
//
//  Created by George Gomes on 27/05/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import Foundation

class BLEBridg{
    
    static let sharedInstance = BLEBridg()
    
    private init(){}
    
    func sendToBLE(word: StringBraille){
      
        var count = 0
        
        var message = ""
        
        for i in 0 ... 4{
            let isIndexValid = word.words.indices.contains(i)
            
            for ib in 1...2{
                if(isIndexValid){
                    if (ib == 1){
                        let type = typeOf(halfLetter: [word.words[i][0], word.words[i][1], word.words[i][2]])
                        message = message + type
                    }else{
                        let type = typeOf(halfLetter: [word.words[i][3], word.words[i][4], word.words[i][5]])
                        message = message + type
                    }
                }else{
                    let type = typeOf(halfLetter: [false, false, false])
                    message = message + type
                }
                count = count + 1
            }
        }
        BLEConnector.shared.send(value: message)
    }
    
    private func typeOf(halfLetter: [Bool]) -> String{
        var type = ""
        switch halfLetter {
        case [false,false, false]:
           type = "A"
        case [true, false, false]:
           type = "B"
        case [true, true, false]:
            type = "C"
        case [false, true, true]:
            type = "D"
        case [false, false, true]:
            type = "E"
        case [true, false, true]:
            type = "F"
        case [false, true, false]:
            type = "G"
        default:
            type = "H"
        }
        return type
    }
}
