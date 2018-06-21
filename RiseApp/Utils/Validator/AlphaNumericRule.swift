//
//  AlphaNumericRule.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 21.06.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import Foundation

public class AlphaNumericRule: CharacterSetRule {
    
    public init(message: String = "Enter valid numeric characters") {
        super.init(characterSet: CharacterSet.alphanumerics, message: message)
    }
}
