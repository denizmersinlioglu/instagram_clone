//
//  CustomImageView.swift
//  RiseApp
//
//  Created by Deniz Mersinlioglu on 23.07.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import UIKit

var imageCache = [String: UIImage]()

class CustomImageView: UIImageView {
    
    var lastURLUsedToLoadImage: String?
    
    func loadImage(urlString: String){
        lastURLUsedToLoadImage = urlString
        
        if let cachedImage = imageCache[urlString] {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err{
                print("Failed to fetch profile image", err)
                return
            }
            
            guard url.absoluteString == self.lastURLUsedToLoadImage,
                let data = data  else {return}
            
            let image = UIImage(data: data)
            imageCache[url.absoluteString] = image
            
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
}
