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
        guard let homeViewController = setupHome(), let sportViewController = setupSport(), let otherViewController = setupOther() else { return }
        setViewControllers([sportViewController, homeViewController, otherViewController], animated: true)
        selectedIndex = 1
    }
    
    private func setupHome()  -> UIViewController? {
        guard let homeViewController = UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(identifier: "home") as? HomeViewController else { return nil }
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        homeNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        homeNavigationController.navigationBar.isHidden = true
        return homeNavigationController
    }
    
    private func setupSport()  -> UIViewController? {
        guard let sportViewController = UIStoryboard.init(name: "Sport", bundle: nil).instantiateViewController(identifier: "sport") as? SportViewController else { return nil }
        let sportNavigationController = UINavigationController(rootViewController: sportViewController)
        sportViewController.tabBarItem = UITabBarItem(title: "Sport", image: UIImage(systemName: "house"), tag: 2)
        sportNavigationController.navigationBar.isHidden = true
        sportNavigationController.navigationBar.prefersLargeTitles = true
        return sportNavigationController
    }
    
    private func setupOther()  -> UIViewController? {
        guard let otherViewController = UIStoryboard.init(name: "Other", bundle: nil).instantiateViewController(identifier: "other") as? OtherViewController else { return nil }
        let otherNavigationController = UINavigationController(rootViewController: otherViewController)
        otherNavigationController.tabBarItem = UITabBarItem(title: "Other", image: UIImage(systemName: "house"), tag: 3)
        otherNavigationController.navigationBar.prefersLargeTitles = true
        return otherNavigationController
    }
    
}
