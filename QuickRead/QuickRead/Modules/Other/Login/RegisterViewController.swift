//
//  RegisterViewController.swift
//  QuickRead
//
//  Created by Dino Martan on 26/04/2021.
//

import UIKit

class RegisterViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
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
            APIHandler.shared.registerUser(username: username, email: email, password: password) { token in
                guard let token = token else {
                    // to do - error handle
                    return
                }
                Profile.shared.setToken(token: token)
            } failure: { error in
                // to do - error handle
            }

        }
    }
    
}
