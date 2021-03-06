//
//  User.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 3.07.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import UIKit

struct User {
    let username: String
    let profileImageUrl: String
    let uid: String
    
    init(uid: String, dictionary: [String: Any]) {
        self.username = dictionary["username"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.uid = uid
    }
}
