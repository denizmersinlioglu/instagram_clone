//
//  AlphaRule.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 21.06.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import Foundation

/**
 `AlphaRule` is a subclass of `CharacterSetRule`. It is used to verify that a field has a
 valid list of alpha characters.
 */
public class AlphaRule: CharacterSetRule {
    
    public init(message: String = "Lütfen alfabetik karakterler giriniz.") {
        super.init(characterSet: CharacterSet.letters, message: message)
    }
}
