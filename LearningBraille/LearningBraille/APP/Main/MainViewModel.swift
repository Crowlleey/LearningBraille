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

    let isRegistered: Observable<([User], Error?)>
    
    init() {
        isRegistered = CoreDataManager.managerInstance().isRegistered()
     
    }
}
