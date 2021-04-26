//
//  LoginViewController.swift
//  QuickRead
//
//  Created by Dino Martan on 26/04/2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

//MARK: - IBActions -

extension LoginViewController {
    
    @IBAction func didTapLoginButton(_ sender: Any) {
    }
    
    @IBAction func didTapForgotPasswordButton(_ sender: Any) {
        guard let forgotPasswordViewController = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(identifier: "forgotPassword") as? ForgotPasswordViewController else { return }
        present(forgotPasswordViewController, animated: true, completion: nil)
    }
    
    @IBAction func didTapRegisterButton(_ sender: Any) {
        guard let registerViewController = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(identifier: "register") as? RegisterViewController else { return }
        present(registerViewController, animated: true, completion: nil)
    }
    
}
