//
//  ProfileViewController.swift
//  QuickRead
//
//  Created by Dino Martan on 28/04/2021.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

//MARK: - IBActions -

extension ProfileViewController {
    
    @IBAction func didTapLogoutButton(_ sender: Any) {
        if Profile.shared.logout() {
            guard let loginViewController = UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(identifier: "login") as? LoginViewController else { return }
            loginViewController.modalPresentationStyle = .fullScreen
            present(loginViewController, animated: true, completion: nil)
        }
        else {
            // to do - handle error
        }
    }
    
}
