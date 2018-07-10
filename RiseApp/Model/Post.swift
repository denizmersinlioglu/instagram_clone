//
//  Post.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 11.07.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import Foundation

struct Post {
    let imageUrl: String
    
    init(dictionary: [String: Any]){
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
    }
}
