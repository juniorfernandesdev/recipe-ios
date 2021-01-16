//
//  Network.swift
//  recipe
//
//  Created by Junior Fernandes on 13/01/21.
//

import Foundation
import Firebase
import SwiftMessages

class Network {

    static let shared = Network()
    private let authManager = Auth.auth()
    private let databaseReference = Firestore.firestore()
    private let storage = Storage.storage()

    func registerNewUser(user: User, password: String, onSuccess: @escaping (String) -> Void, onError: @escaping (Error) -> Void) {
        authManager.createUser(withEmail: user.email, password: password) { (result, error) in
            guard let result = result, error == nil else {
                onError(error!)
                return
            }
            let uid = result.user.uid
            self.databaseReference.collection("users").document(uid).setData([
                "name": user.name,
                "email": user.email
            ]) { (error) in
                guard error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                self.storage.reference(withPath: "fotos").child(uid+".png").putData(user.image, metadata: nil) { (result, error) in
                    guard error == nil, let result = result else {
                        print("Error")
                        onError(error!)
                        return
                    }
                    print("Enviado")
                    onSuccess(uid)
                }
            }
        }
    }

    func loggin(email: String, senha: String, onSuccess: @escaping (User) -> Void, onError: @escaping (Error) -> Void) {
        
        authManager.signIn(withEmail: email, password: senha) { (result, error) in
            guard let result = result, error == nil else {
                print(error.debugDescription)
                onError(error!)
                return
            }

            let uid = result.user.uid
            self.databaseReference.collection("users").document(uid).getDocument { (document, error) in
                if let document = document, document.exists {
                    guard let data = document.data() else {
                        // erro caso usuario nao tenha cadastrado informacao
                        return
                    }
                    let user = User(name: data["name"] as! String, email: email, uid: uid, image: Data())
                    onSuccess(user)
                } else {
                    REAlertas.shared.showAlert(title: "ERROR", message: "Usuario não encontrado", type: .error)
                }
            }
        }
    }

    func isLogged() -> Bool {
        guard let _ = authManager.currentUser else {
            return false
        }
        return true
    }

    func logout() -> Bool {
        do {
            try authManager.signOut()
            return true
        } catch {
            return false
        }
    }

}
