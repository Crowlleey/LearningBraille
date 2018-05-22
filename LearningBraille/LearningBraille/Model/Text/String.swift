//
//  Text.swift
//  LearningBraille
//
//  Created by George Gomes on 19/03/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import Foundation

extension String{
 
    func convertToBraille() -> StringBraille{
        var stringBraile: StringBraille = StringBraille()
    
        
        let words = self.stringToArray()
        
      
        // Process each word to know its type
        for word in words{
            let type = typeOf(word)
            
            // knowing the type of the word, the word is sent for translation
            switch (type){
            
                case .fullLower:
                    stringBraile.words.append(contentsOf: self.transelateFullLower(word: word))
                    
                    break
                case .fullUper:
                    break
                case .letterMix:
                    break
                case .numeral:
                    break
                case .numeralMixLetter:
                    print("NumeralMixLetter")
                    break
            }
        }
        
        return stringBraile
    }

// MARK: WORD PROCESSING
    
    // Array with each word
    func stringToArray() -> [String] {
        var words = [String]()
            self.enumerateSubstrings(in: self.startIndex..<self.endIndex, options: .byWords) {
            ss, r, r2, stop in
            words.append(ss!)
        }
        return words
    }
    
    // Process each word to know its type
    private func typeOf(_ word: String) -> WordType{
  
        var low = false
        var upper = false
        var number = false
        var simble = false
        
        for letter in word{
            //Check letter type in word
            let st = String(letter)
            if(st.lowercased() == st){low = true}
            if(st.uppercased() == st){upper = true}
            
            //Check if contain simbles
            for simb in simbles {
                if(simb == String(letter)){
                    print("HAS SIMBLE")
                    simble = true
                }
            }
        }
        
        //Check if contain a number
        let decimalCharacters = CharacterSet.decimalDigits
        let decimalRange = word.rangeOfCharacter(from: decimalCharacters)
        if decimalRange != nil {
            number = true
        }
        
        var type: WordType!
        
        if(low == true && upper == false && number == false && simble == false){type = WordType.fullLower}
        else if(low == false && upper == true && number == false && simble == false){type = WordType.fullUper}
        else if(low == true && upper == true && number == false && simble == false){type = WordType.letterMix}
        else if(low == false && upper == false && number == true && simble == false){type = WordType.numeral}
        else{type = WordType.numeralMixLetter}
        
        return type
    }
    
    private func transelateFullLower(word: String) -> [LetterBraille]{
        
        var leters = [LetterBraille]()
        
        for letter in word{
            print(letter)
        }
        
        return [[true, false, false, false, false, false]]
    }
}








