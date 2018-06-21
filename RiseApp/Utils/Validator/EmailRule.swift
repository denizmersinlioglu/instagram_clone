//
//  EmailRule.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 21.06.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import Foundation

/*
 EmailRule is a subclass of RegexRule that defines how a email is validated.
 */
public class EmailRule: Rule {
    
    private var message: String!
    
    
    // Regular express string to be used in email validation.
    let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    public func errorMessage() -> String {
        return message
    }
    
    public init(message : String = "Lütfen geçerli bir email adresi giriniz."){
        self.message = message
    }
    
    public func validate(_ value: String) -> Bool {
        let regexRule = RegexRule(regex: regex)
        guard regexRule.validate(value) else {return false}
        let minimumLengthRule = MinimumLengthRule(minimumLength: 8)
        guard minimumLengthRule.validate(value) else {return false}
        let groups = value.split(separator: "@")
        let emailPart = groups[0]
        let domainPart = groups[1]
        
        // @ işaretinin sağında yer alan bilgiler tamamen nümerik olmamalı.
        guard !CharacterSet.decimalDigits.isSuperset(of: CharacterSet.init(charactersIn: String(domainPart))) else { return false }
        
        // @ işaretinin sağına ""www"" girilemeyecek.
        guard !domainPart.contains("www") else { return false }
        
        // Web/Domain adresinde noktadan sonra en az 2 karakter girilmemiş olmamalıdır.
        guard let indexOfLastDot = domainPart.range(of: ".", options: .backwards)?.lowerBound else { return false }
        let stringAfterDot = domainPart[indexOfLastDot..<domainPart.endIndex]
        guard stringAfterDot.count > 2 else { return false}
        
        // @ solunda tek başında “yok” ya da “YOK” kelimesi olmamalıdır.
        guard emailPart.caseInsensitiveCompare("yok") != ComparisonResult.orderedSame else { return false }
        
        // Web/Domain adresinde ararda 2 tane nokta karakteri girilmemelidir.
        guard !domainPart.contains("..") else { return false }
        
        //  Domain adresinde en az bir tane nokta olmalıdır.
        guard !domainPart.hasPrefix(".") && !domainPart.hasPrefix(",") && !domainPart.hasPrefix("/") else { return false }
        
        //  Mail adresi www ile başlamamalıdır.
        guard !emailPart.hasPrefix("www") else { return false }

        return true
        
    }
}

