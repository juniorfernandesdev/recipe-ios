//
//  REAlertas.swift
//  recipe
//
//  Created by Junior Fernandes on 15/01/21.
//

import Foundation
import SwiftMessages

class REAlertas: MessageView {

    static let shared = REAlertas()

    enum typeMessage {
        case sucess
        case error
    }

    fileprivate let succesMessage: MessageView = {
        let messageView = MessageView.viewFromNib(layout: .cardView)
        messageView.configureDropShadow()
        messageView.configureTheme(.success, iconStyle: .light)
        messageView.button?.isHidden = true
        return messageView
    }()

    fileprivate let errorMessage: MessageView = {
        let messageView = MessageView.viewFromNib(layout: .cardView)
        messageView.configureDropShadow()
        messageView.configureTheme(.error, iconStyle: .light)
        messageView.button?.isHidden = true
        return messageView
    }()

    func showAlert(title: String, message: String, type: typeMessage) {
        switch type {
            case .sucess:
                self.succesMessage.configureContent(title: title, body: message)
                SwiftMessages.show(view: self.succesMessage)
            case .error:
                self.errorMessage.configureContent(title: title, body: message)
                SwiftMessages.show(view: self.errorMessage)
        }
    } 
}
