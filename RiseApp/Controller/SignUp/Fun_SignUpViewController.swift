//
//  SignUpController.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 21.06.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import UIKit
import Firebase

extension SignUpController {
    
    // MARK: UI
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = .white
        view.addSubview(plusPhotoButton)
        
        view.addSubview(alreadyHaveAccountButton)
        alreadyHaveAccountButton.anchor(top: nil, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 50)
        
        plusPhotoButton.anchor(top: view.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 40, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 140, height: 140)
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(emailTextField)
        
        setupInputFields()
    }
    
    fileprivate func setupInputFields(){
        let stackView = UIStackView(arrangedSubviews: [emailTextField, userNameTextField, passwordTextField, signUpButton])
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        view.addSubview(stackView)
        stackView.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 20, paddingLeft: 40, paddingBottom: 0, paddingRight: 40, width: 0, height: 200)
    }
    
    @objc func handlePlusPhoto(){
        let imagePickerControler = UIImagePickerController()
        imagePickerControler.delegate = self
        imagePickerControler.allowsEditing = true
        present(imagePickerControler, animated: true, completion: nil)
    }
    
    @objc func handleTextInputChange(){
        let isFormValid = !(emailTextField.text?.isEmpty)! && !(userNameTextField.text?.isEmpty)! && !(passwordTextField.text?.isEmpty)!
        
        signUpButton.isEnabled = isFormValid
        signUpButton.backgroundColor = isFormValid ? UIColor.rgb(red: 17, green: 154, blue: 237) : UIColor.rgb(red: 149, green: 204, blue: 244)
    }

    // MARK: Server Side
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
            guard let uid = result?.user.uid else {return}
            
            self.uploading(img: image, completion: { (url) in
                
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
        
        storeImageReference.putData(uploadImageData, metadata: nil, completion: { (metaData, err) in
            if let err = err{
                print("fail to save user profile image", err)
                return
            }
            
            print("succesfully saved user profile image")
            storeImageReference.downloadURL(completion: { (url, err) in
                if let err = err{
                    print("fail to get saved image url", err)
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

extension SignUpController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
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

