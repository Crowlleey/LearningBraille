//
//  TextBraille.swift
//  LearningBraille
//
//  Created by George Gomes on 19/03/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import Foundation

typealias LetterBraille = (Bool,Bool,Bool,Bool,Bool,Bool)

struct StringBraille{

     var a : String!
    
    var letters: [LetterBraille]!
    
    init(a: String) {
        self.a = a
    }

}


extension StringBraille{
 
    func brailleConvert() -> String{
        let i = "asda"
        return i
    }
    
    func typeToProcess(_ word: Any) -> WordType {
        return .numeral
    }
    
    
}
