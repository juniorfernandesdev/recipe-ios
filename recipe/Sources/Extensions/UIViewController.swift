//
//  UIViewController.swift
//  recipe
//
//  Created by Bryan Barreto on 14/01/21.
//

import UIKit


extension UIViewController {
    
    func dismissKeyboardOnTap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard(){
        self.view.endEditing(true)
    }
}
