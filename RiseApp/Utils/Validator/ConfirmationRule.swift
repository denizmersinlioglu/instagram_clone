//
//  ConfirmationRule.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 21.06.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import Foundation

public class ConfirmationRule: Rule {
    /// parameter confirmString string to which original text field will be compared to.
    private let confirmString : String
    /// parameter message: String of error message.
    private var message : String
    
   
    public init(confirmString: String, message : String = "Alanlar eşleşmedi."){
        self.confirmString = confirmString
        self.message = message
    }
    
    public func validate(_ value: String) -> Bool {
        return confirmString == value
    }
 
    public func errorMessage() -> String {
        return message
    }
}
