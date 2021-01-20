//
//  HeaderCadastroTableViewCell.swift
//  recipe
//
//  Created by Junior Fernandes on 19/01/21.
//

import UIKit

protocol showInsertContent {
    func openModal()
}

enum StepDescription: String {
    case _1d4 = "1 de 4"
    case _2d4 = "2 de 4"
    case _3d4 = "3 de 4"
    case _4d4 = "4 de 4"
}

class HeaderCadastroTableViewCell: UITableViewCell {
    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var stepProgress: UILabel!
    @IBOutlet weak var lblTitle: UILabel!

    var delegate: showInsertContent?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

    func setup(title: String, stepProgress: StepDescription, isHidden: Bool) {
        self.lblTitle.text = title
        self.stepProgress.text = stepProgress.rawValue
        self.btnAdd.isHidden = isHidden
    }
    
    @IBAction func btnShowModal(_ sender: UIButton) {
        print("Clicou")
        self.delegate?.openModal()

    }
}
