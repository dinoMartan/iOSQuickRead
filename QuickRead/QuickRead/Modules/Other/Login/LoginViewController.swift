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

//MARK: - Private extensions -

private extension LoginViewController {
    
    private func loginUser(username: String, password: String, success: @escaping (() -> Void), failure: @escaping ((Error) -> Void)) {
        let profile = Profile.shared
        profile.saveLoginData(username: username, password: password)
        profile.silentLogin {
            success()
        } failure: { error in
            failure(error)
        }
    }
    
}

//MARK: - IBActions -

extension LoginViewController {
    
    @IBAction func didTapLoginButton(_ sender: Any) {
        guard let username = usernameTextField.text, let password = passwordTextField.text else { return }
        if StringCheck.checkStrings(strings: [username, password]) {
            loginUser(username: username, password: password) {
                guard let menuViewController = UIStoryboard.init(name: "Menu", bundle: nil).instantiateViewController(withIdentifier: "menu") as? TabBarViewController else { return }
                menuViewController.modalPresentationStyle = .fullScreen
                self.present(menuViewController, animated: true, completion: nil)
            } failure: { error in
                // to do - handle error
            }
        }
    }
    
    @IBAction func didTapForgotPasswordButton(_ sender: Any) {
        guard let forgotPasswordViewController = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(identifier: "forgotPassword") as? ForgotPasswordViewController else { return }
        present(forgotPasswordViewController, animated: true, completion: nil)
    }
    
    @IBAction func didTapRegisterButton(_ sender: Any) {
        guard let registerViewController = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(identifier: "register") as? RegisterViewController else { return }
        registerViewController.delegate = self
        present(registerViewController, animated: true, completion: nil)
    }
    
}

//MARK: - Delegates -

extension LoginViewController: RegisterViewControllerDelegate {
    
    func didRegister(username: String, password: String) {
        self.loginUser(username: username, password: password) {
            guard let menuViewController = UIStoryboard.init(name: "Menu", bundle: nil).instantiateViewController(withIdentifier: "menu") as? TabBarViewController else { return }
            menuViewController.modalPresentationStyle = .fullScreen
            self.present(menuViewController, animated: true, completion: nil)
        } failure: { error in
            // to do - handle error
        }

    }
    
}
