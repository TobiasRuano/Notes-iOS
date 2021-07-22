//
//  NOTabBarController.swift
//  Notes
//
//  Created by Tobias Ruano on 20/02/2021.
//

import UIKit

class NOTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemBlue
        viewControllers = [createHomeVC(), createUserVC()]
    }
    
    private func createHomeVC() -> UINavigationController {
        let homeVC = HomeViewController()
        homeVC.title = "Notes"
        let noteImage = UIImage(systemName: "note")
        homeVC.tabBarItem = UITabBarItem(title: "Notes", image: noteImage, tag: 0)
        return UINavigationController(rootViewController: homeVC)
    }
    
    private func createUserVC() -> UINavigationController {
        let userVC = UserViewController()
        userVC.title = "Account"
        let userimage = UIImage(systemName: "person.crop.circle")
        userVC.tabBarItem = UITabBarItem(title: "Account", image: userimage, tag: 1)
        return UINavigationController(rootViewController: userVC)
    }
}
