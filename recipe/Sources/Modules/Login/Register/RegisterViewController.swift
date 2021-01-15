//
//  RegisterViewController.swift
//  recipe
//
//  Created by Junior Fernandes on 14/01/21.
//

import UIKit

class RegisterViewController: UIViewController {
    // MARK: - Properties
    
    // MARK: - IBOutlets
    @IBOutlet weak var btnRegistrar: UIButton!
    @IBOutlet weak var btnCancelar: UIButton!
    
    
    
    @IBOutlet weak var nome: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var senha: UITextField!
    @IBOutlet weak var confirmarSenha: UITextField!
    
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.setDelegates()
        self.dismissKeyboardOnTap()
    }
    
    
    // MARK: - IBActions
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Public Methods
    
    // MARK: - Private Methods
    private func configureUI(){
        self.btnRegistrar.layer.cornerRadius = 25
        self.btnCancelar.layer.cornerRadius = 25
    }
    
    private func setDelegates(){
        self.email.delegate = self
        self.nome.delegate = self
        self.senha.delegate = self
        self.confirmarSenha.delegate = self
    }
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.nome:
            self.email.becomeFirstResponder()
            break
            
        case self.email:
            self.senha.becomeFirstResponder()
            break
            
        case self.senha:
            self.confirmarSenha.becomeFirstResponder()
            break
            
        case self.confirmarSenha:
            self.confirmarSenha.resignFirstResponder()
            break
            
        default:
            break
        }
        
        return true
    }
}
