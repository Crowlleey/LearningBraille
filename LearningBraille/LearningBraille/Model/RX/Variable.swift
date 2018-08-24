//
//  Observable.swift
//  LearningBraille
//
//  Created by George Gomes on 24/08/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import Foundation

class Variable<T> {
    
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T?{
        didSet{
            listener?(value!)
        }
    }
    
    func bind(listener: Listener?){
        self.listener = listener
        listener?(value!)
    }
    
    init(_ v:T) {
        value = v
    }
}
