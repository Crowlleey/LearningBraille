//
//  MainViewModel.swift
//  LearningBraille
//
//  Created by George Gomes on 23/08/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct MainViewModel {

    let isRegistered2: Observable<([User], Error?)>
//    let isRegistered = Variable<([User], Error?)>(([], nil))
    
    init() {
//
//        isRegistered2 = CoreDataManager.managerInstance().isRegistered()
//            .map{$0}

        isRegistered2 = CoreDataManager.managerInstance().isRegistered()
            .map({ (r) in
                print(r.0)
                return r
            })
    }
}
