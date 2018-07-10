//
//  UserProfilePostCell.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 11.07.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import UIKit

class UserProfilePostCell: UICollectionViewCell {
    
    var post: Post?{
        didSet{
            guard let postImageUrl = post?.imageUrl,
                let url = URL(string: postImageUrl) else {return}
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                if let err = err{
                    print("Failed to fetch profile image", err)
                    return
                }
                
                guard let data = data else {return}
                let image = UIImage(data: data)
                
                DispatchQueue.main.async {
                    self.photoImageView.image = image
                }
                }.resume()
        }
    }
    
    let photoImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .white
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(photoImageView)
        photoImageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
