//
//  ResetPasswordViewController.swift
//  QuickRead
//
//  Created by Dino Martan on 29/04/2021.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet private weak var validationCodeTextField: UITextField!
    @IBOutlet private weak var newPasswordTextField: UITextField!
    @IBOutlet private weak var confirmedPasswordTextField: UITextField!
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

//MARK: - Private extensions -

private extension ResetPasswordViewController {
    
    private func resetPassword() {
        guard checkFields() else { return }
        validateCode {
            self.executePasswordChange()
        } failure: {
            Alerter.showOneButtonAlert(on: self, title: .wrongCode, message: .wrongCode, actionTitle: .ok, handler: nil)
        }
    }
    
    private func executePasswordChange() {
        APIHandler.shared.changePassword(password: newPasswordTextField.text!) {
            Alerter.showOneButtonAlert(on: self, title: .success, message: .passwordChanged, actionTitle: .ok) { _ in
                self.dismiss(animated: true, completion: nil)
            }
        } failure: { error in
            Alerter.showOneButtonAlert(on: self, title: .oops, error: error, actionTitle: .ok, handler: nil)
        }
    }
    
    private func validateCode(success: @escaping (() -> Void), failure: @escaping (() -> Void)) {
        APIHandler.shared.validateResetToken(token: validationCodeTextField.text!) { authorizationToken in
            guard let token = authorizationToken else {
                Alerter.showOneButtonAlert(on: self, title: .error, message: .wrongResponse, actionTitle: .ok, handler: nil)
                return
            }
            Profile.shared.setToken(token: token)
            success()
        } failure: { error in
            Alerter.showOneButtonAlert(on: self, title: .oops, error: error, actionTitle: .ok, handler: nil)
        }
    }
    
    private func checkFields() -> Bool {
        guard let code = validationCodeTextField.text, let password = newPasswordTextField.text, let confirmedPassword = confirmedPasswordTextField.text, StringCheck.checkStrings(strings: [code, password, confirmedPassword]), password != confirmedPassword else {
            Alerter.showOneButtonAlert(on: self, title: .oops, message: .checkFields, actionTitle: .ok, handler: nil)
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
