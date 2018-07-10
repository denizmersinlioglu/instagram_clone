//
//  UserProfileController.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 3.07.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import UIKit
import Firebase

class UserProfileController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    var user: User?
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        fetchUser()
        
        collectionView?.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headerID")
        collectionView?.register(UserProfilePostCell.self, forCellWithReuseIdentifier: cellId)
        
        setupLogoutButton()
        
        fetchPosts()
    }
    
    fileprivate func fetchPosts(){
        guard let uid = Auth.auth().currentUser?.uid else {return}
        let ref = Database.database().reference().child("posts").child(uid)
        ref.observeSingleEvent(of: .value, andPreviousSiblingKeyWith: { (snapshot, metadata) in
            guard let dictionaries = snapshot.value as? [String: Any] else {return}
            dictionaries.forEach({ (key,value) in
                //print("key \(key), value \(value)")
                
                guard let dictionary = value as? [String: Any] else {return}
                let post = Post(dictionary: dictionary)
                self.posts.append(post)
            })
            
            self.collectionView?.reloadData()
            
        }) { (err) in
            print("failed to fetch posts",err)
        }
    }
    
    fileprivate func setupLogoutButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "gear").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleLogOut))
    }
    
    @objc func handleLogOut(){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            do{
                try Auth.auth().signOut()
                let loginVC = LoginController()
                let navController = UINavigationController(rootViewController: loginVC)
                self.present(navController, animated: true, completion: nil)
            }catch let singOutErr{
                print("Failed to sign out", singOutErr)
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
        }))
        
        present(alertController, animated: true, completion: nil)
    
    }
    
    fileprivate func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot.value ?? "")
            guard let dictionary = snapshot.value as? [String: Any] else {return}
            
            self.user = User(dictionary: dictionary)
            self.navigationItem.title = self.user?.username
            
            self.collectionView?.reloadData()
        }) { (err) in
            print("Failed to fetch user:", err)
        }
    }
    
}

extension UserProfileController{
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerID", for: indexPath) as! UserProfileHeader
        header.user = self.user
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! UserProfilePostCell
        cell.post = posts[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2)/3
        return CGSize(width: width, height: width)
    }
}
