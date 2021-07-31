//
//  RegisterViewController.swift
//  QuickRead
//
//  Created by Dino Martan on 26/04/2021.
//

import UIKit

protocol RegisterViewControllerDelegate: AnyObject {
    
    func didRegister(username: String, password: String)
    
}

class RegisterViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    //MARK: - Public properties
    
    weak var delegate: RegisterViewControllerDelegate?
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

//MARK: - IBActions -

extension RegisterViewController {
    
    @IBAction func didTapRegisterButton(_ sender: Any) {
        guard let email = emailTextField.text, let username = usernameTextField.text, let password = passwordTextField.text else { return }
        if StringCheck.checkStrings(strings: [username, email, password]) {
            APIHandler.shared.registerUser(username: username, email: email, password: password) { _ in
                self.delegate?.didRegister(username: username, password: password)
                self.dismiss(animated: true, completion: nil)
            } failure: { error in
                Alerter.showOneButtonAlert(on: self, title: .oops, error: error, actionTitle: .ok, handler: nil)
            }

        }
    }
    
    @IBAction func didTapAround(_ sender: Any) {
        view.endEditing(true)
    }
    
}
