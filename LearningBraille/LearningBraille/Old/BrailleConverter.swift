//
//  BrailleConverter.swift
//  LearningBraille
//
//  Created by George Gomes on 09/03/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//


import Foundation


class BrailleConverter{
    typealias braille = [Bool]
    
    var gp = Group()
    
    func translateThis(_ phrase: String) -> [[[Bool]]]{
        var translatedSentence = [[[Bool]]]()
        
        var words = [String]()
        phrase.enumerateSubstrings(in: phrase.startIndex..<phrase.endIndex, options: .byWords) {
            ss, r, r2, stop in
            words.append(ss!)
        }
        
        for word in words{
            let type = defineTypeOf(word)
           
            switch type{
                
            case .fullLower:
                translatedSentence.append(translateOnlyWords(word))
                break
            case .fullUper:
                if(word.count == 1){
                    translatedSentence.append([gp.upper])
                }else{
                    translatedSentence.append([gp.upper])
                    translatedSentence.append([gp.upper])
                }
                translatedSentence.append(translateOnlyWords(word.lowercased()))
                break
            case .letterMix:
                break
            case .numeral:
                break
            case .numeralMixLetter:
                break
            }
            translatedSentence.append([gp.space])
        }
        return translatedSentence
    }
    
    func defineTypeOf(_ word: String) -> WordType{
        var low = false
        var upper = false
//        var number = false
//        var simble = false
        for letter in word{
            let st = String(letter)
            if(st.lowercased() == st){low = true}
            if(st.uppercased() == st){upper = true}
            
        }
        
        var type: WordType!
        
        if(low == true && upper == false){type = WordType.fullLower
        }else if(low == false && upper == true){type = WordType.fullUper}
        else if (low == true && upper == true){type = WordType.letterMix}
        
        return type
    }
    
    func translateOnlyWords(_ word: String) -> [[Bool]]{
        let value = letterPositionIn(word)
        var valueToReturn = [[Bool]]()
        // only word (number) to decode
        for w in value{
            
            var i = [Int]()
            for s in w{
                i.append(Int(String(s))!)
            }
            let card = gp.buildCard(i[1], i[0])
            
             valueToReturn.append(card)
        }
        //return gp.buildCard(Int(value[1])!,Int( value[0])!)
        return valueToReturn
    }
    
    func letterPositionIn(_ phrase: String) -> [String]{
        var arrayNumber: [String] = []
        for letter in phrase{
         
            for i in 96...122{
                if(letter == Character(UnicodeScalar(i)!)){
                    let iS = i - 97
                    if (iS <= 9 ){
                        arrayNumber.append("0\(iS)")
                    }else{
                        arrayNumber.append(String(i - 97))
                    }
                }
            }
        }
        return arrayNumber
    }
}



    
    
    


