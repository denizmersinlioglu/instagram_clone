//
//  UserProfileHeader.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 3.07.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import UIKit
import Firebase

class UserProfileHeader: UICollectionViewCell {
    
    // MARK: - Decleration
    var user: User?{
        didSet{
            guard let profileImageUrl = user?.profileImageUrl else {return}
            profileImageView.loadImage(urlString: profileImageUrl)
            guard let username = user?.username else {return}
            usernameLabel.text = username
            setupEditFollowButton()
        }
    }
    
    let profileImageView: CustomImageView = {
        let imageView = CustomImageView()
        return imageView
    }()
    
    let gridButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "grid"), for: .normal)
        return button
    }()
    
    let listButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "list"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    let bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "ribbon"), for: .normal)
        button.tintColor = UIColor(white: 0, alpha: 0.2)
        return button
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "username"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let postLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "11\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "posts", attributes: [.foregroundColor: UIColor.lightGray , .font: UIFont.systemFont(ofSize: 14)]))
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let followerLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "followers", attributes: [.foregroundColor: UIColor.lightGray , .font: UIFont.systemFont(ofSize: 14)]))
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let followingLabel: UILabel = {
        let label = UILabel()
        let attributedText = NSMutableAttributedString(string: "0\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "followings", attributes: [.foregroundColor: UIColor.lightGray , .font: UIFont.systemFont(ofSize: 14)]))
        label.attributedText = attributedText
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var editProfileFollowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit Profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 3
        button.addTarget(self, action: #selector(handleEditFollow), for: .touchUpInside)
        return button
    }()
    
    @objc func handleEditFollow(){
        guard let currentUserId = Auth.auth().currentUser?.uid else {return}
        guard let userId = user?.uid else {return}
        
        let values =  [userId: editProfileFollowButton.titleLabel?.text == "Unfollow" ? 0 : 1]
        let ref = Database.database().reference().child("following").child(currentUserId)
        ref.updateChildValues(values) { (err, ref) in
            if let err = err{
                print("failed to follow user ", err)
            }
            guard let title = self.editProfileFollowButton.titleLabel?.text else {return}
            self.setupEditFollowButtonUI(isFollowing: !(title == "Unfollow"))
            print("succesfully followed the user :", self.user?.username ?? "")
        }
    }
    
    fileprivate func setupEditFollowButton(){
        guard let currentUserId = Auth.auth().currentUser?.uid,
            let userId = user?.uid else {return}
        guard currentUserId != userId else {return}
        Database.database().reference().child("following").child(currentUserId).child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
            if let value = snapshot.value as? Int{
                 self.setupEditFollowButtonUI(isFollowing: value == 1)
            }else{
                 self.setupEditFollowButtonUI(isFollowing: false)
            }
        }) { (err) in
            print("failed to check if following", err)
        }
    }
    
    fileprivate func setupEditFollowButtonUI(isFollowing: Bool){
        editProfileFollowButton.setTitle(isFollowing ? "Unfollow" : "Follow" , for: .normal)
        editProfileFollowButton.backgroundColor = isFollowing ? .white : UIColor.rgb(red: 17, green: 154, blue: 237)
        editProfileFollowButton.setTitleColor(isFollowing ? .black : .white, for: .normal)
        editProfileFollowButton.layer.borderColor = UIColor(white: 0, alpha: 0.2).cgColor
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProfileImage()
        setupBottomToolbar()
        setupUsernameLabel()
        setupUserStatsView()
        setupEditProfileButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
