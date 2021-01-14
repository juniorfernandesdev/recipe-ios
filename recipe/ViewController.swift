//
//  ViewController.swift
//  recipe
//
//  Created by Junior Fernandes on 13/01/21.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

//        Network.shared.registerNewUser(user: User(name: nil, email: "junior2@gmail.com", password: "123456789", uid: nil)) { (uid) in
//            print(uid)
//        } onError: { (error) in
//            print(error.localizedDescription)
//        }

        Network.shared.loggin(user: User(name: nil, email: "junior2@gmail.com", password: "123456789", uid: nil)) { (uid) in
//            print()
        } onError: { (error) in
//            print()
        }

    }

}

