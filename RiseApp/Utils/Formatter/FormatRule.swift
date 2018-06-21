//
//  FormatRule.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 21.06.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import Foundation

protocol FormatRule{
    
    func format(input: String) -> String?
    
    func reverseFormat(input: String) -> String?
    
    func getErrorMessage() -> String?
}
