//
//  ViewController.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 21.06.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import UIKit
import Firebase

extension SignUpViewController {

    @objc func handleSignUp(){
        // TODO: Add validators
        guard let email = emailTextField.text, !email.isEmpty,
            let username = userNameTextField.text, !username.isEmpty,
            let password = passwordTextField.text, !password.isEmpty else {return}
       
        
        Auth.auth().createUser(withEmail: email, password: password) { (result: AuthDataResult?, error: Error?) in
            if let error = error{
                print("fail to create user:", error)
                return
            }
            guard let image = self.plusPhotoButton.imageView?.image else {return}
            
            self.uploading(img: image, completion: { (url) in
                guard let uid = result?.user.uid else {return}
                
                let dictionaryValues = ["username": username, "profileImageUrl": url]
                let values = [uid: dictionaryValues]
                print("Succesfull adding user", result?.user.uid ?? "")
                Database.database().reference().child("users").updateChildValues(values, withCompletionBlock: { (err, ref) in
                    if let err = err{
                        print("fail to save user to database", err)
                        return
                    }
                    print("successfully save the user to database")
                    
                    guard let mainTabBarController = UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController else {return}
                    mainTabBarController.setupViewControllers()
                    self.dismiss(animated: true, completion: nil)
                })
            })
        }
    }
    
    func uploading( img : UIImage,completion: @escaping ((String) -> Void)) {
        var strURL = ""
        let filename = NSUUID().uuidString
        let storeImageReference = Storage.storage().reference().child("profile_images").child(filename)
        
        guard let uploadImageData = UIImagePNGRepresentation((img)) else {return}
        
        storeImageReference.putData(uploadImageData, metadata: nil, completion: { (metaData, error) in
            storeImageReference.downloadURL(completion: { (url, err) in
                
                if let err = err{
                    print("fail to save user profile image", err)
                    return
                }
                if let urlText = url?.absoluteString {
                    strURL = urlText
                    completion(strURL)
                }
                print("succesfully saved user profile image to:", strURL)
            })
        })
    }
    
    @objc func handleShowLogin(){
       _ = navigationController?.popViewController(animated: true)
    }
}

extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            plusPhotoButton.setImage(editedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            plusPhotoButton.setImage(originalImage.withRenderingMode(.alwaysOriginal), for: .normal)
        }
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width/2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.black.cgColor
        plusPhotoButton.layer.borderWidth = 3
        dismiss(animated: true, completion: nil)
    }
}

