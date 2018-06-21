//
//  CreditCardNumberRule.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 21.06.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import Foundation

class LuhnCheckRule: Rule{
    
    private var message: String = "Lütfen geçerli bir kart numarası giriniz"
    
    public init(){}
    
    public init(message: String = "Lütfen geçerli bir kart numarası giriniz"){
        self.message = message
    }
    
    public func validate(_ cardNo: String) -> Bool{
        let input = cardNo.replacingOccurrences(of: " ", with: "")
        return luhnCheck(number: input)
    }
    
    func luhnCheck(number: String) -> Bool {
        var sum = 0
        let digitStrings = number.reversed().map { String($0) }
        
        for tuple in digitStrings.enumerated() {
            if let digit = Int(tuple.element) {
                let odd = tuple.offset % 2 == 1
                
                switch (odd, digit) {
                case (true, 9):
                    sum += 9
                case (true, 0...8):
                    sum += (digit * 2) % 9
                default:
                    sum += digit
                }
            } else {
                return false
            }
        }
        
        return sum % 10 == 0
    }
    
    public func errorMessage() -> String{
        return message
    }
    
}
