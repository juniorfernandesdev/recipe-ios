//
//  HomeViewController.swift
//  recipe
//
//  Created by Junior Fernandes on 15/01/21.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.isLogged()
        self.configureUI()
    }
    
    private func configureUI(){
        self.navigationController?.navigationBar.isHidden = true
    }

    private func isLogged() {
        if !Network.shared.isLogged() {
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async {
                self.present(vc, animated: false, completion: nil)
            }

        }
    }

    @IBAction func Logout(_ sender: UIButton) {
        if Network.shared.logout() {
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async {
                self.present(vc, animated: true, completion: nil)
            }
        } else {
            REAlertas.shared.showAlert(title: "ERROR", message: "Não foi possivel desconectar!", type: .error)
        }
    }
    
    @IBAction func adcReceitaTapped(_ sender: UIButton) {
        let vc = CadastroReceitaViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
}
