//
//  ResetPasswordViewController.swift
//  QuickRead
//
//  Created by Dino Martan on 29/04/2021.
//

import UIKit

protocol ResetPasswordViewControllerDelegate: AnyObject {
    
    //func resetPassword(validationCode: String, newPassword: String)
    
}

class ResetPasswordViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var validationCodeTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmedPasswordTextField: UITextField!
    
    //MARK: - Public properties
    
    weak var delegate: ResetPasswordViewControllerDelegate?
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

//MARK: - Private extensions -

private extension ResetPasswordViewController {
    
    private func resetPassword() {
        guard checkFields() else { return }
        validateCode { token in
            self.executePasswordChange(token: token)
        } failure: {
            let alert = UIAlertController(title: "Wrong code", message: "Looks like your code is incorrect. Please try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    private func executePasswordChange(token: String) {
        // call API - /changePassword
    }
    
    private func validateCode(success: @escaping ((String) -> Void), failure: @escaping (() -> Void)) {
        // call API - /validateResetToken -> token: String
    }
    
    private func checkFields() -> Bool {
        guard let code = validationCodeTextField.text, let password = newPasswordTextField.text, let confirmedPassword = confirmedPasswordTextField.text, StringCheck.checkStrings(strings: [code, password, confirmedPassword]), password != confirmedPassword else {
            // to do - handle error
            let alert = UIAlertController(title: "Someting is wrong", message: "Make sure to input all fields and that passwords match.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return false
        }
        return true
    }
    
}

//MARK: - IBActions -

extension ResetPasswordViewController {
    
    @IBAction func didTapResetPasswordButton(_ sender: Any) {
        resetPassword()
    }
    
    @IBAction func didTapAround(_ sender: Any) {
        view.endEditing(true)
    }
    
}
