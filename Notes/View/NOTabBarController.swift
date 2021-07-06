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
        viewControllers = [createHomeVC()]
    }
    
    private func createHomeVC() -> UINavigationController {
        let homeVC = HomeViewController()
        homeVC.title = "Notes"
        let noteImage = UIImage(systemName: "note.text")
        homeVC.tabBarItem = UITabBarItem(title: "Notes", image: noteImage, tag: 0)
        return UINavigationController(rootViewController: homeVC)
    }
}
