//
//  Formatter.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 21.06.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

class TextFieldFormatter{

    var formatRule: FormatRule?
    
    func format(input: String?) -> String?{
        guard let formatRule = formatRule,let input = input else {return nil}
        return formatRule.format(input: input)
    }
    
    func reverseFormat(input: String?) -> String? {
        guard let formatRule = formatRule,let input = input else {return nil}
        return formatRule.reverseFormat(input: input)
    }
    
    init(formatRule: FormatRule) {
        self.formatRule = formatRule
    }
}





