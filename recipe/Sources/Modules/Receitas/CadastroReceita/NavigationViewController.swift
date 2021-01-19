//
//  NavigationViewController.swift
//  recipe
//
//  Created by Bryan Barreto on 18/01/21.
//

import UIKit

class NavigationViewController: UINavigationController {
    
    let backButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(backToScreen))
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    @objc func backToScreen(){
        self.dismiss(animated: true, completion: nil)
    }
    
    private func configure(){
        let vc = CadastroReceitaViewController()
        self.viewControllers = [vc]
        self.navigationItem.leftBarButtonItem = self.backButton
    }

}
