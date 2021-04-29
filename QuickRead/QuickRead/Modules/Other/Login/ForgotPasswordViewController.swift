//
//  ForgotPasswordViewController.swift
//  QuickRead
//
//  Created by Dino Martan on 26/04/2021.
//

import UIKit

protocol ForgotPasswordViewControllerDelegate: AnyObject {
    
    func showPasswordReset()
    
}

class ForgotPasswordViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var emailTextField: UITextField!
    
    //MARK: - Public properties
    
    weak var delegate: ForgotPasswordViewControllerDelegate?
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

//MARK: - Private extensions -

private extension ForgotPasswordViewController {
    
    private func forgotPassword() {
        guard checkInputs() else { return }
        sendEmail()
    }
    
    private func sendEmail() {
        APIHandler.shared.forgotPassword(email: emailTextField.text!) {
            self.dismiss(animated: true, completion: nil)
            self.delegate?.showPasswordReset()
        } failure: { error in
            let alert = UIAlertController(title: "Something went wrong", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    private func checkInputs() -> Bool {
        guard let email = emailTextField.text, StringCheck.checkStrings(strings: [email]) else {
            // to do - alert
            let alert = UIAlertController(title: "Error", message: "Make sure to input your email.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return false
        }
        return true
    }
    
}

//MARK: - IBActions -

extension ForgotPasswordViewController {
    
    @IBAction func didTapResetPasswordButton(_ sender: Any) {
        forgotPassword()
    }
    
    @IBAction func didTapHaveCodeButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        delegate?.showPasswordReset()
    }
    
    @IBAction func didTapAround(_ sender: Any) {
        view.endEditing(true)
    }
    
}
