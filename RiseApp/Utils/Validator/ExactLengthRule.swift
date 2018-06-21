//
//  ExactLengthRule.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 21.06.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import Foundation

/**
 `ExactLengthRule` is a subclass of Rule that is used to make sure a the text of a field is an exact length.
 */
public class ExactLengthRule : Rule {
    /// parameter message: String of error message.
    private var message : String = "6 karakter uzunluğunda olmalı"
    /// parameter length: Integer value string length
    private var length : Int = 6
   
    public init(length: Int, message : String = "%ld karakter uzunluğunda olmalı"){
        self.length = length
        self.message = String(format: message, self.length)
    }
    
    public func validate(_ value: String) -> Bool {
        return value.count == length
    }
    
    public func errorMessage() -> String {
        return message
    }
}
