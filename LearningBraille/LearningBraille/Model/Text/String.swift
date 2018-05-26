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
                    stringBraile.words.append(contentsOf: self.translateLetters(word))
                    stringBraile.words.append(space())
                    break
                case .fullUper:
                    stringBraile.words.append(uppercaseSimble())
                    stringBraile.words.append(uppercaseSimble())
                    stringBraile.words.append(contentsOf: self.translateLetters(word.lowercased()))
                    stringBraile.words.append(space())
                    break
                case .letterMix:
                    stringBraile.words.append(contentsOf: self.translateLetters(word))
                    stringBraile.words.append(space())
                    break
                case .numeral:
                    stringBraile.words.append(numeral())
                    stringBraile.words.append(contentsOf: self.translateNumerals(word))
                    stringBraile.words.append(space())
                    break
                case .numeralMixLetter:
                    stringBraile.words.append(contentsOf: self.translateLetters(word))
                    stringBraile.words.append(space())
                    break
            }
        }
        return stringBraile
    }

// MARK: WORD PROCESSING
    
    // Array with each word
    func stringToArray() -> [String] {

        var words = [String]()
        let wordsToReturn = self.split(separator: " ")
        
        for wor in wordsToReturn{
            words.append(String(wor))
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
            //Check if contain simbles
            for simb in simbles {
                if(simb == String(letter)){
                    simble = true
                }else if(CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: String(letter)))){
                    number = true
                }else{
                    //Check letter type in word
                    let st = String(letter)
                    if(st.lowercased() == st){low = true}
                    if(st.uppercased() == st){upper = true}
                }
            }
        }
     
        var type: WordType!
        
        if(low == true && upper == false && number == false && simble == false){type = WordType.fullLower}
        else if(low == false && upper == true && number == false && simble == false){type = WordType.fullUper}
        else if(low == true && upper == true && number == false && simble == false){type = WordType.letterMix}
        else if(low == false && upper == false && number == true && simble == false){type = WordType.numeral}
        else{type = WordType.numeralMixLetter}
        
        return type
    }
    
    private func translateLetters(_ word: String) -> [LetterBraille]{
        var letters = [LetterBraille]()
        
        let lowerCase = CharacterSet.lowercaseLetters
        var isSimble = false
        
        for currentCharacter in word.unicodeScalars {
            for simb in simbles { // if is a simble
                if(simb == String(String(currentCharacter))){
                    isSimble = true
                }
            }
            if(isSimble){
                  letters.append(ParseJSON.sharedInstance.brailleFrom(this: String(currentCharacter)))
            }else if(CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: String(currentCharacter)))){ // if is a number
                letters.append(numeral())
                letters.append(ParseJSON.sharedInstance.brailleFromThis(number: String(currentCharacter)))
                
            }else{
                if lowerCase.contains(currentCharacter) { // if is lowercase
                    letters.append(ParseJSON.sharedInstance.brailleFrom(this: String(currentCharacter)))
                } else {// if is uppercase
                    letters.append(uppercaseSimble())
                    letters.append(ParseJSON.sharedInstance.brailleFrom(this: String(currentCharacter).lowercased()))
                }
            }
        }
        return letters
    }
    
    private func translateNumerals(_ numbers: String) -> [LetterBraille]{
        var letters = [LetterBraille]()
        for number in numbers{
            letters.append(ParseJSON.sharedInstance.brailleFromThis(number: String(number)))
        }
        return letters
    }
    
    private func space() -> LetterBraille{
        return  ParseJSON.sharedInstance.brailleFrom(this: " ")
    }
    
    private func lowercaseSimble() -> LetterBraille{
        return ParseJSON.sharedInstance.brailleFromThis(simble: "lowercaseSimble")
    }
    
    private func uppercaseSimble() -> LetterBraille{
        return ParseJSON.sharedInstance.brailleFromThis(simble: "uppercaseSimble")
    }
    
    private func numeral() -> LetterBraille{
        return ParseJSON.sharedInstance.brailleFromThis(simble:  "numeral")
    }
}








