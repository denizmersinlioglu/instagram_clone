//
//  Validator.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 21.06.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import Foundation

/*
 This validation class should be added as a parameter to ViewController that will display
 validation fields.
 */

public class Validator {
    
    var rules: [Rule]?
    
    public init(rules: [Rule]){
        self.rules = rules
    }
    
    func validate(input: String) -> (success: Bool, errorText: String?){
        guard let rules = rules else { return (false,nil) }
        guard let fail = rules.first(where: { !$0.validate(input) }) else { return (true,nil) }
        return(false, fail.errorMessage())
    }
    
    
}




