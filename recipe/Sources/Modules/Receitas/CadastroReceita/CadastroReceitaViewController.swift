//
//  CadastroReceitaViewController.swift
//  recipe
//
//  Created by Bryan Barreto on 18/01/21.
//

import UIKit
import StepIndicator

enum Step: Int {
    case StepOneTableViewCell = 0
    case  StepTwoTableViewCell = 1
    case  StepThreeTableViewCell = 2
    case  StepFourTableViewCell = 3
}

class CadastroReceitaViewController: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var step: StepIndicatorView!
    @IBOutlet weak var btnAvancar: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
        self.configureTableView()
        print("============+> \(self.step.currentStep)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Cadastro"
        self.showInformation()
    }
    
    private func configureUI(){
        self.navigationController?.isToolbarHidden = false
        self.btnAvancar.layer.cornerRadius = 25
        self.wrapperView.layer.cornerRadius = 25
        
//        self.pageControl.numberOfPages = 5
    }

    private func configureTableView() {

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.registerCell(id: "StepOneTableViewCell")
        self.registerCell(id: "StepTwoTableViewCell")
        self.registerCell(id: "StepThreeTableViewCell")
        self.registerCell(id: "StepFourTableViewCell")
        self.registerCell(id: "HeaderCadastroTableViewCell")

//        self.tableView.tableHeaderView =

    }

    private func registerCell(id: String) {
        self.tableView.register(UINib(nibName: id, bundle: nil), forCellReuseIdentifier: id)

    }

    private func showInformation() {
        let vc = RecomendacoesViewController()
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func backButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func informationButtonTapped(_ sender: UIBarButtonItem) {
        self.showInformation()
    }

    @IBAction func avancarTapped(_ sender: UIButton) {
        if self.step.currentStep < self.step.numberOfSteps - 1 {
            self.step.currentStep = self.step.currentStep + 1
            self.tableView.reloadData()
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
            self.tableView.reloadData()
            if self.step.currentStep < 3 {
                self.btnAvancar.setTitle("Avançar", for: .normal)
            }
        }
    }
}

extension CadastroReceitaViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        switch self.step.currentStep {
            case Step.StepOneTableViewCell.rawValue:
                cell = tableView.dequeueReusableCell(withIdentifier: StepOneTableViewCell.id) as? StepOneTableViewCell
                break
            case Step.StepTwoTableViewCell.rawValue:
                cell = tableView.dequeueReusableCell(withIdentifier: StepTwoTableViewCell.id) as? StepTwoTableViewCell
                break
            case Step.StepThreeTableViewCell.rawValue:
                cell = tableView.dequeueReusableCell(withIdentifier: StepThreeTableViewCell.id) as? StepThreeTableViewCell
                break
            case Step.StepFourTableViewCell.rawValue:
                cell = tableView.dequeueReusableCell(withIdentifier: StepFourTableViewCell.id) as? StepFourTableViewCell
                break
            default:
                return UITableViewCell()
        }
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCadastroTableViewCell") as? HeaderCadastroTableViewCell
        cell?.delegate = self

        switch self.step.currentStep {
            case Step.StepOneTableViewCell.rawValue:
                cell?.setup(title: "INFORMAÇÕES", stepProgress: ._1d4, isHidden: true)
                tableView.isUserInteractionEnabled = false
                break
            case Step.StepTwoTableViewCell.rawValue:
                cell?.setup(title: "INGREDIENTES", stepProgress: ._2d4, isHidden: false)
                tableView.isUserInteractionEnabled = true
                break
            case Step.StepThreeTableViewCell.rawValue:
                cell?.setup(title: "PREPARO", stepProgress: ._3d4, isHidden: false)
                tableView.isUserInteractionEnabled = true
                break
            case Step.StepFourTableViewCell.rawValue:
                cell?.setup(title: "FOTO", stepProgress: ._4d4, isHidden: true)
                tableView.isUserInteractionEnabled = false
                break
            default:
                return UITableViewCell()
        }

        return cell ?? UITableViewCell()
    }
}

extension CadastroReceitaViewController: showInsertContent {
    func openModal() {
        let vc = InsertContentViewController()
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true, completion: nil)
    }


}
