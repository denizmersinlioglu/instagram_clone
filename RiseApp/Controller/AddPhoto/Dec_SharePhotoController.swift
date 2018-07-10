//
//  SharePhotoControllerUI.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 11.07.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import UIKit
import Firebase

class SharePhotoController: UIViewController {
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 14)
        return tv
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    var selectedImage: UIImage?{
        didSet{
            guard let selectedImage = selectedImage else {return}
            imageView.image = selectedImage
        }
    }
  
}
