//
//  BindingFields.swift
//  LearningBraille
//
//  Created by George Gomes on 24/08/18.
//  Copyright © 2018 George Gomes. All rights reserved.
//

import Foundation
import UIKit

class BindingTextField: UITextField {
    
    var textChanged: (String) -> () = { _ in }
    
    func bind(callback: @escaping (String) -> ()) {
        self.textChanged = callback
        self.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField){
        self.textChanged(textField.text!)
    }
}

