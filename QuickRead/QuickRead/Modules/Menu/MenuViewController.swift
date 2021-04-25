//
//  MenuViewController.swift
//  QuickRead
//
//  Created by Dino Martan on 24/04/2021.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        //guard let homeNavigationViewController = UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(identifier: "homeNavigation") as? HomeNavigationViewController else { return }
        //guard let sportNavigationViewController = UIStoryboard.init(name: "Sport", bundle: nil).instantiateViewController(identifier: "sportNavigation") as? HomeNavigationViewController else { return }
        
        //setViewControllers([homeNavigationViewController], animated: true)
    }

}
