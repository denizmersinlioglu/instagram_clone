//
//  FirebaseUtils.swift
//  RiseApp
//
//  Created by Deniz Mersinlioglu on 24.07.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import Firebase

extension Database{
    static func fetchUser(with uid: String, completion: @escaping (User) -> ()){
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let userDictionary = snapshot.value as? [String: Any] else {return}
            let user = User(uid: uid, dictionary: userDictionary)
            
            completion(user)
        }) { (err) in
            print("failed to fetch for the posts")
        }
    }
}
