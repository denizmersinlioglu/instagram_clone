//
//  RegexRule.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 21.06.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import Foundation

public class RegexRule : Rule {
    
    private var REGEX: String = "^(?=.*?[A-Z]).{8,}$"

    private var message : String
    
    public init(regex: String, message: String = "Geçersiz giriş"){
        self.REGEX = regex
        self.message = message
    }
    
    public func validate(_ value: String) -> Bool {
        let test = NSPredicate(format: "SELF MATCHES %@", self.REGEX)
        return test.evaluate(with: value)
    }
    
    public func errorMessage() -> String {
        return message
    }
}
