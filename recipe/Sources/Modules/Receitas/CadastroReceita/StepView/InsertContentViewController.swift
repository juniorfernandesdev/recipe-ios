//
//  InsertContentViewController.swift
//  recipe
//
//  Created by Junior Fernandes on 19/01/21.
//

import UIKit

class InsertContentViewController: UIViewController {
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var viewBg: UIView!
    @IBOutlet weak var lblContent: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()

        // Do any additional setup after loading the view.
    }

    private func configureView() {
        self.btnAdd.layer.cornerRadius = 25
        self.btnCancel.layer.cornerRadius = 25
        self.viewBg.layer.cornerRadius = 25

        self.lblContent.layer.cornerRadius = 20
        self.lblContent.layer.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1).cgColor
    }

    @IBAction func addContentAction(_ sender: UIButton) {
    }

    @IBAction func cancelAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

}
