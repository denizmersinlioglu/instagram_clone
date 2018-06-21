//
//  MinimumLengthRule.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 21.06.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import Foundation

class MinimumLengthRule: Rule{
    
    private var minimumLength: Int = 2
    
    private var message: String = "En az 2 karakter uzunluğunda olmalıdır"
    
    public init(){}
    
    public init(minimumLength: Int, message: String = "En az %1d karakter uzunluğunda olmalıdır"){
        self.minimumLength = minimumLength
        self.message = String(format: message, self.minimumLength)
    }
    
    public func validate(_ value: String) -> Bool{
        return value.count >= minimumLength
    }
    
    public func errorMessage() -> String{
        return message
    }
    
}
