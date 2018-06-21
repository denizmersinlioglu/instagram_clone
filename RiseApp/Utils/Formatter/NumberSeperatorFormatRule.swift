//
//  CardNumberFormatRule.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 21.06.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import Foundation

class NumberSeperatorFormatRule: FormatRule{

    var message: String? = "Invalid input"
    var seperator: String?
    var groupCount: Int?
   
    init(with seperator: String, groupCount: Int, message: String? = "Invalid input") {
        self.seperator = seperator
        self.message = message
        self.groupCount = groupCount
    }
    
    func format(input: String) -> String? {
        guard let seperator = seperator else {return nil}
        guard let groupCount = groupCount else {return nil}
        let rawValue = input.replacingOccurrences( of:"[^0-9]", with: "", options: .regularExpression)
        return rawValue.inserting(separator: seperator, every: groupCount)
    }
    
    func reverseFormat(input: String) -> String? {
        guard let seperator = seperator else {return nil}
        return input.pairs.joined(separator: seperator)
    }
    
    func getErrorMessage() -> String? {
        return message
    }
    
    
}
