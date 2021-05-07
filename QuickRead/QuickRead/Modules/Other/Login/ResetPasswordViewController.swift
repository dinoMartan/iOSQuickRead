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
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.alpha = 0
    }
    
}

//MARK: - Private extensions -

private extension ResetPasswordViewController {
    
    private func showLoadingView() {
        activityView.startAnimating()
        UIView.animate(withDuration: 0.5) {
            self.loadingView.alpha = 1
        }
    }
    
    private func hideLoadingView() {
        activityView.stopAnimating()
        UIView.animate(withDuration: 0.5) {
            self.loadingView.alpha = 0
        }
    }
    
    private func resetPassword() {
        guard checkFields() else { return }
        showLoadingView()
        validateCode {
            self.executePasswordChange {
                Alerter.showOneButtonAlert(on: self, title: .success, message: .passwordChanged, actionTitle: .ok) { _ in
                    self.hideLoadingView()
                    self.dismiss(animated: true, completion: nil)
                }
            } failure: { error in
                self.hideLoadingView()
                Alerter.showOneButtonAlert(on: self, title: .oops, error: error, actionTitle: .ok, handler: nil)
            }
        }
    }
    
    private func executePasswordChange(success: @escaping (() -> Void), failure: @escaping ((Error) -> Void)) {
        APIHandler.shared.changePassword(password: newPasswordTextField.text!) {
            success()
        } failure: { error in
            failure(error)
        }
    }
    
    private func validateCode(success: @escaping (() -> Void)) {
        APIHandler.shared.validateResetToken(token: validationCodeTextField.text!) { authorizationToken in
            if authorizationToken == nil {
                Alerter.showOneButtonAlert(on: self, title: .error, message: .wrongResponse, actionTitle: .ok, handler: nil)
            }
            Profile.shared.setToken(token: authorizationToken!)
            success()
        } failure: { error in
            Alerter.showOneButtonAlert(on: self, title: .oops, error: error, actionTitle: .ok, handler: nil)
        }
    }
    
    private func checkFields() -> Bool {
        guard let code = validationCodeTextField.text, let password = newPasswordTextField.text, let confirmedPassword = confirmedPasswordTextField.text, StringCheck.checkStrings(strings: [code, password, confirmedPassword]), password == confirmedPassword else {
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
