//
//  ExpandingCell.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 22.06.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import UIKit
import expanding_collection

class DemoCollectionViewCell: BasePageCollectionCell {
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var customTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        customTitle.layer.shadowRadius = 2
        customTitle.layer.shadowOffset = CGSize(width: 0, height: 3)
        customTitle.layer.shadowOpacity = 0.2
    }
}
