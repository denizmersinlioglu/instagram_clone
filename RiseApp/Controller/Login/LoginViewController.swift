//
//  LoginViewController.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 5.07.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import UIKit
import Firebase

extension LoginViewController {
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    @objc func handleShowSignUp(){
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    @objc func handleTextInputChange(){
        let isFormValid = !(emailTextField.text?.isEmpty)! && !(passwordTextField.text?.isEmpty)!
        loginButton.isEnabled = isFormValid
        loginButton.backgroundColor = isFormValid ? UIColor.rgb(red: 17, green: 154, blue: 237) : UIColor.rgb(red: 149, green: 204, blue: 244)
    }
    
    @objc func handleSignIn(){
        guard let email = emailTextField.text,
            let password = passwordTextField.text else {return}
        Auth.auth().signIn(withEmail: email, password: password) { (result, err) in
            if let err = err{
                print("failed to sign in", err)
                return
            }
            print("Logged in with user ", result?.user.uid ?? "")
            
            guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else {return}
            mainTabBarController.setupViewControllers()
            
            self.dismiss(animated: true, completion: nil)
        }
    }
}
