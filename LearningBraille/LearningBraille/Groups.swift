//
//  Groups.swift
//  LearningBraille
//
//  Created by George Gomes on 10/03/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import Foundation
struct Group {
    
    private var group =
    [[true, false, false, false],   //
    [true, false, true, false],     //
    [true, true, false, false],     //
    [true, true, false, true],      //
    [true, false, false, true],     //
    [true, true, true, false],      //
    [true, true, true, true],       //
    [true, false, true, true],      //
    [false, true, true, false],     //
    [false, true,true, true]]       //
    
    private var typeG =
    [[false, false], [true, false], [true, true], [false, true]]
    
    private var upercase = [false, true, false, false, false, true]
    private var spc = [false,false,false,false,false,false]
    
    var upper: [Bool]{
        get{
            return self.upercase
        }
    }
    
    var space: [Bool]{
        get{
            return spc
        }
    }
    
    func buildCard(_ g: Int,_ t: Int) -> [Bool] {
        var toReturn = group[g]
        
        for i in 0...1{
            
            toReturn.append(typeG[t][i])
        }
        
        
        return toReturn
    }
}
