//
//  CharacterSetRule.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 21.06.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import Foundation

public class CharacterSetRule: Rule {
    /// NSCharacter that hold set of valid characters to hold
    private let characterSet: CharacterSet
    /// String that holds error message
    private var message: String
    
    init(characterSet: CharacterSet, message: String = "Lütfen geçerli karakterler giriniz.") {
        self.characterSet = characterSet
        self.message = message
    }
    

    public func validate(_ value: String) -> Bool {
        for uni in value.unicodeScalars {
            guard let uniVal = UnicodeScalar(uni.value), characterSet.contains(uniVal) else {
                return false
            }
        }
        return true
    }
    
    /**
     Displays error message when field fails validation.
     
     - returns: String of error message.
     */
    public func errorMessage() -> String {
        return message
    }
}
