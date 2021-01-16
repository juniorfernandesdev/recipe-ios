//
//  RegisterViewController.swift
//  recipe
//
//  Created by Junior Fernandes on 14/01/21.
//

import UIKit
import extension_recipes

protocol LoginSucess {
    func userCreatedSucess()
}

class RegisterViewController: UIViewController {
    // MARK: - Properties
    var imageData: Data = Data()
    var delegate: LoginSucess?
    var loadding: UIView?
    
    // MARK: - IBOutlets
    @IBOutlet weak var btnRegistrar: UIButton!
    @IBOutlet weak var btnCancelar: UIButton!
    @IBOutlet weak var ivProfile: UIImageView!

    
    
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

        self.ivProfile.layer.cornerRadius = self.ivProfile.frame.width / 2
        self.ivProfile.layer.borderWidth = 3
        self.ivProfile.layer.borderColor = UIColor.white.cgColor
    }
    
    
    // MARK: - IBActions
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func registerButtonTapped(_ sender: UIButton) {
        let isLoadding = self.showLoading()
        #warning("Criar validação dos campos")
        Network.shared.registerNewUser(user: User(name: self.nome.text!, email: self.email.text!, uid: nil, image: self.imageData), password: self.senha.text!) { (uid) in
            print("Sucesso")
            self.dismiss(animated: true, completion: nil)
            self.delegate?.userCreatedSucess()
            self.hideLoading(v: isLoadding)
        } onError: { (error) in
            print(error.localizedDescription)
            self.hideLoading(v: isLoadding)
        }
    }

    @IBAction func addPictureProfile(_ sender: UIButton) {
        let alert = UIAlertController(title: "Selecione uma opção", message: "Teste", preferredStyle: .actionSheet)
        let camera = UIAlertAction(title: "Camera", style: .default) { _ in
            self.createPicker(source: .camera)
        }
        let galeria = UIAlertAction(title: "Galeria", style: .default) { _ in
            self.createPicker(source: .photoLibrary)
        }

        let cancelar = UIAlertAction(title: "Cancelar", style: .cancel)

        alert.addAction(camera)
        alert.addAction(galeria)
        alert.addAction(cancelar)
        present(alert, animated: true, completion: nil)
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

    private func createPicker(source: UIImagePickerController.SourceType) {
        if (UIImagePickerController.availableMediaTypes(for: source) != nil) {
            let picker = UIImagePickerController()
            picker.allowsEditing = true
            picker.delegate = self
            picker.sourceType = source

            present(picker, animated: true, completion: nil)
        } else {
            print("============> Camera")
        }
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

extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let profile = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        self.ivProfile.image = profile

        self.imageData = profile.pngData()!

        self.dismiss(animated: true, completion: nil)
    }

}
