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
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var loadingView: UIView!
    @IBOutlet weak var loadingActivityView: UIActivityIndicatorView!
    
    //MARK: - Public properties
    
    weak var delegate: ForgotPasswordViewControllerDelegate?
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        loadingView.alpha = 0
    }

}

//MARK: - Private extensions -

private extension ForgotPasswordViewController {
    
    private func showLoadingAnimation() {
        loadingActivityView.startAnimating()
        UIView.animate(withDuration: 0.5) {
            self.loadingView.alpha = 1
        }
    }
    
    private func hideLoadingAnimation() {
        loadingActivityView.stopAnimating()
        UIView.animate(withDuration: 0.5) {
            self.loadingView.alpha = 0
        }
    }
    
    private func forgotPassword() {
        guard checkInputs() else { return }
        sendEmail()
    }
    
    private func sendEmail() {
        showLoadingAnimation()
        APIHandler.shared.forgotPassword(email: emailTextField.text!) {
            self.hideLoadingAnimation()
            self.dismiss(animated: true, completion: nil)
            self.delegate?.showPasswordReset()
        } failure: { error in
            self.hideLoadingAnimation()
            Alerter.showOneButtonAlert(on: self, title: .oops, error: error, actionTitle: .ok, handler: nil)
        }
    }
    
    private func checkInputs() -> Bool {
        guard let email = emailTextField.text, StringCheck.checkStrings(strings: [email]) else {
            Alerter.showOneButtonAlert(on: self, title: .oops, message: .checkFields, actionTitle: .ok, handler: nil)
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
