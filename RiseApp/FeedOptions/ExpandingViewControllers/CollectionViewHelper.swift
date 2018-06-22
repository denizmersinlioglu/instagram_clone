//
//  CollectionViewHelper.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 22.06.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func getReusableCellWithIdentifier<T: UICollectionViewCell>(_ indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.cellIdentifier, for: indexPath) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(T.cellIdentifier) ")
        }
        
        return cell
    }
}

// MARK: UITableViewCell

protocol CollectionViewCellIdentifiable {
    static var cellIdentifier: String { get }
}

extension CollectionViewCellIdentifiable where Self: UICollectionViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell: CollectionViewCellIdentifiable {}
