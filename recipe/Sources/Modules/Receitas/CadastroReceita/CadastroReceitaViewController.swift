//
//  CadastroReceitaViewController.swift
//  recipe
//
//  Created by Bryan Barreto on 18/01/21.
//

import UIKit
import StepIndicator

class CadastroReceitaViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var step: StepIndicatorView!
    @IBOutlet weak var btnAvancar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Cadastro"
    }
    
    private func configureUI(){
        self.navigationController?.isToolbarHidden = false
        self.btnAvancar.layer.cornerRadius = 25
        self.wrapperView.layer.cornerRadius = 25
        
        self.pageControl.numberOfPages = 5
    }
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func informationButtonTapped(_ sender: UIBarButtonItem) {
        
    }
    @IBAction func avancarTapped(_ sender: UIButton) {
        
        
        
        if self.step.currentStep < self.step.numberOfSteps - 1 {
            self.step.currentStep = self.step.currentStep + 1
            
            if self.step.currentStep == 3 {
                self.btnAvancar.setTitle("Enviar", for: .normal)
            }
        }else {
            print("enviar dados")
        }
    }
    
    @IBAction func voltarTapped(_ sender: UIButton) {
        if self.step.currentStep != 0 {
            self.step.currentStep = self.step.currentStep - 1
            
            if self.step.currentStep < 3 {
                self.btnAvancar.setTitle("Avançar", for: .normal)
            }
        }
    }
}
