//
//  FoldingTableViewCell.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 22.06.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//
import UIKit

class ChallangeFeedTableViewCell: FoldingCell {
    
    @IBOutlet var closeNumberLabel: UILabel!
    @IBOutlet var openNumberLabel: UILabel!
    
    var number: Int = 0 {
        didSet {
            closeNumberLabel.text = String(number)
            openNumberLabel.text = String(number)
        }
    }
    
    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
}

// MARK: - Actions ⚡️

extension ChallangeFeedTableViewCell {
    
    @IBAction func buttonHandler(_: AnyObject) {
        print("tap")
    }
}
