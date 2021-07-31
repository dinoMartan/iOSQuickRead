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
        delegate = self
        guard let homeViewController = setupHome(), let sportViewController = setupSport(), let otherViewController = setupCategories(), let profileViewController = setupProfile() else { return }
        setViewControllers([sportViewController, homeViewController, otherViewController, profileViewController], animated: true)
        selectedIndex = 1
    }
    
    private func setupHome()  -> UIViewController? {
        guard let homeViewController = UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(identifier: "home") as? HomeViewController else { return nil }
        let homeNavigationController = UINavigationController(rootViewController: homeViewController)
        homeNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        homeNavigationController.navigationBar.isHidden = true
        homeNavigationController.navigationItem.backBarButtonItem?.isEnabled = false
        homeNavigationController.interactivePopGestureRecognizer?.isEnabled = false
        return homeNavigationController
    }
    
    private func setupSport()  -> UIViewController? {
        guard let sportViewController = UIStoryboard.init(name: "Sport", bundle: nil).instantiateViewController(identifier: "sport") as? SportViewController else { return nil }
        let sportNavigationController = UINavigationController(rootViewController: sportViewController)
        sportViewController.tabBarItem = UITabBarItem(title: "Sport", image: UIImage(systemName: "house"), tag: 2)
        sportNavigationController.navigationBar.prefersLargeTitles = true
        sportNavigationController.navigationBar.isHidden = true
        sportNavigationController.navigationItem.backBarButtonItem?.isEnabled = false
        sportNavigationController.interactivePopGestureRecognizer?.isEnabled = false
        return sportNavigationController
    }
    
    private func setupCategories()  -> UIViewController? {
        guard let otherViewController = UIStoryboard.init(name: "Other", bundle: nil).instantiateViewController(identifier: "other") as? OtherViewController else { return nil }
        let otherNavigationController = UINavigationController(rootViewController: otherViewController)
        otherNavigationController.tabBarItem = UITabBarItem(title: "Categories", image: UIImage(systemName: "house"), tag: 3)
        otherNavigationController.navigationBar.prefersLargeTitles = true
        return otherNavigationController
    }
    
    private func setupProfile()  -> UIViewController? {
        guard let profileViewController = UIStoryboard.init(name: "Profile", bundle: nil).instantiateViewController(identifier: "profile") as? ProfileViewController else { return nil }
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "house"), tag: 4)
        profileNavigationController.navigationBar.prefersLargeTitles = true
        return profileNavigationController
    }
    
}

extension TabBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        viewController != selectedViewController
    }
    
}
