//
//  LoginViewController.swift
//  recipe
//
//  Created by Junior Fernandes on 14/01/21.
//

import UIKit
import TextFieldEffects

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    // MARK: - IBOutlets
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var senha: UITextField!
    
    @IBOutlet weak var btnEntrar: UIButton!
    @IBOutlet weak var btnRegistrar: UIButton!
    
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var senhaView: UIView!
    
    
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.setDelegates()
        self.dismissKeyboardOnTap()
    }
    

    
    // MARK: - IBActions
    @IBAction func btnEntrarTapped(_ sender: UIButton) {
        guard let email = self.email.text, !(self.email.text?.isEmpty ?? false),
              let senha = self.senha.text, !(self.senha.text?.isEmpty ?? false)  else {
            //error
            print("Preencha os campos")
            return
        }
        self.login(email: email, senha: senha)
    }
    
    @IBAction func btnRegistrarTapped(_ sender: UIButton) {
        let registerVC = RegisterViewController()
        self.present(registerVC, animated: true, completion: nil)
    }
    
    
    // MARK: - Public Methods
    
    // MARK: - Private Methods
    private func configureUI(){
        self.btnEntrar.layer.cornerRadius = 25
        self.btnRegistrar.layer.cornerRadius = 25
    }
    
    private func setDelegates(){
        self.email.delegate = self
        self.senha.delegate = self
    }
    
    private func login(email: String, senha: String){
        Network.shared.loggin(email: email, senha: senha) { (usuario) in
            print(usuario)
        } onError: { (error) in
            print(error.localizedDescription)
        }
    }

}

// MARK: - Textfield functions
extension LoginViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.email:
            self.senha.becomeFirstResponder()
            break
            
        case self.senha:
            self.senha.resignFirstResponder()
            break
            
        default:
        break
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case self.email:
            self.emailView.backgroundColor = .white
            break
            
        case self.senha:
            self.senhaView.backgroundColor = .white
            break
            
        default:
        break
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {
            self.paintTextfieldView(textField, color: .red)
            return
        }
        self.paintTextfieldView(textField, color: .green)
    }
    
    private func paintTextfieldView(_ textField: UITextField, color: UIColor){
        switch textField {
        case self.email:
            self.emailView.backgroundColor = color
            break
            
        case self.senha:
            self.senhaView.backgroundColor = color
            break
            
        default:
            break
        }
    }
}

