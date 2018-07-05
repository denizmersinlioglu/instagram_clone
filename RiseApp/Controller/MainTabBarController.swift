//
//  MainTabBarController.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 3.07.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Auth.auth().currentUser == nil{
            DispatchQueue.main.async {
                let loginVC = LoginViewController()
                let navigationController = UINavigationController(rootViewController: loginVC)
                self.present(navigationController, animated: true, completion: nil)
            }
            return
        }

        let layout = UICollectionViewFlowLayout()
        let userProfileCollectionViewController = UserProfileCollectionViewController(collectionViewLayout: layout)
        let signUpViewControlller = SignUpViewController()
        let navController = UINavigationController(rootViewController: userProfileCollectionViewController)
        
        navController.tabBarItem.image = #imageLiteral(resourceName: "profile_unselected")
        navController.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile_selected")
        
        tabBar.tintColor = .black
        
        viewControllers = [navController, UIViewController()]
    }
}
