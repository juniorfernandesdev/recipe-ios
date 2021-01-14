//
//  Network.swift
//  recipe
//
//  Created by Junior Fernandes on 13/01/21.
//

import Foundation
import Firebase

class Network {

    static let shared = Network()
    private let authManager = Auth.auth()
    private let databaseReference = Firestore.firestore()

    func registerNewUser(user: User, onSuccess: @escaping (String) -> Void, onError: @escaping (Error) -> Void) {
        authManager.createUser(withEmail: user.email!, password: user.password!) { (result, error) in
            guard let result = result, error == nil else {
                onError(error!)
                return
            }
            let uid = result.user.uid
            self.databaseReference.collection("users").document(uid).setData([
                "name": "Los Angeles",
                "state": "CA",
                "country": "USA"
            ]) { (error) in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                onSuccess(uid)
            }
        }
    }

    func loggin(user: User, onSuccess: @escaping (String) -> Void, onError: @escaping (Error) -> Void) {
        authManager.signIn(withEmail: user.email!, password: user.password!) { (result, error) in
            guard let result = result, error == nil else {
                print(error.debugDescription)
                return
            }

            let uid = result.user.uid
            self.databaseReference.collection("users").document(uid).getDocument { (document, error) in
                if let document = document, document.exists {
                    let data = document.data()
                    print(data)
                } else {
                    print("Usuario nao cadastrado")
                }
            }
        }
    }

}
