//
//  Alerter.swift
//  QuickRead
//
//  Created by Dino Martan on 04/05/2021.
//

import UIKit

enum AlertTitle: String {
    
    case error = "Error"
    case wrongCode = "Wrong code"
    case oops = "Oops"
    case success = "Success"
    
}

enum AlertMessage: String {

    case passwordChanged = "Your password has been changed."
    case wrongCode = "Looks like your code is incorrect. Please try again."
    case checkFields = "Please make sure you input all fields."
    case wrongResponse = "We couldn't get the right response."
    
}

enum AlertButton: String {
    
    case ok = "OK"
    
}

final class Alerter {
    
    static func showOneButtonAlert(on viewController: UIViewController, title: AlertTitle, message: AlertMessage, actionTitle: AlertButton, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title.rawValue, message: message.rawValue, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle.rawValue, style: .default, handler: handler)
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func showOneButtonAlert(on viewController: UIViewController, title: AlertTitle, error: Error, actionTitle: AlertButton, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: title.rawValue, message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle.rawValue, style: .default, handler: handler)
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }
    
}
