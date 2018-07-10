//
//  SharePhotoController.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 10.07.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import UIKit
import Firebase

extension SharePhotoController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.rgb(red: 240, green: 240, blue: 240)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(handleShare))
        setupImageAndTextFields()
    }
    
    func setupImageAndTextFields(){
        let containerView = UIView()
        containerView.backgroundColor = .white
        
        view.addSubview(containerView)
        containerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 100)
        
        containerView.addSubview(imageView)
        imageView.anchor(top: containerView.topAnchor, left: containerView.leftAnchor, bottom: containerView.bottomAnchor, right: nil, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 0, width: 84, height: 0)
        
        containerView.addSubview(textView)
        textView.anchor(top: containerView.topAnchor, left: imageView.rightAnchor, bottom: containerView.bottomAnchor, right: containerView.rightAnchor, paddingTop: 0, paddingLeft: 4, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    @objc func handleShare(){
        guard let image = selectedImage,
            let uploadData = UIImageJPEGRepresentation(image, 0.5),
            let caption = textView.text, caption.count > 0 else {return}
        
        navigationItem.rightBarButtonItem?.isEnabled = false
        
        let filename = NSUUID().uuidString
        let storeImageReference = Storage.storage().reference().child("posts").child(filename)
        
        storeImageReference.putData(uploadData, metadata: nil) { (metadata, err) in
            if let err = err {
                print("Failed to upload image", err)
                self.navigationItem.rightBarButtonItem?.isEnabled = true
                return
            }
            print("Succesfully uploaded post")
            
            storeImageReference.downloadURL { (url, err) in
                if let err = err {
                    print("Failed to get download URL", err)
                    return
                }
                guard let imageUrl = url?.absoluteString else {return}
                print("Succesfully get download URL", imageUrl)
                self.saveToDatabeWithImageUrl(imageUrl)
            }
        }
    }
    
    
    func saveToDatabeWithImageUrl(_ imageUrl: String){
        guard let postImage = selectedImage else {return}
        guard let caption = textView.text else {return}
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let userPostRef = Database.database().reference().child("posts").child(uid)
        let ref = userPostRef.childByAutoId()
        let values = ["imageUrl": imageUrl,
                      "caption": caption,
                      "imageWidth" : postImage.size.width,
                      "imageHeight": postImage.size.height,
                      "creationDate": Date().timeIntervalSince1970] as [String: Any]
        ref.updateChildValues(values) { (err, ref) in
            if let err = err {
                print("failed to save post to DB", err)
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            }
            
            print("Succesfully saved post to DB")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
