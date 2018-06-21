//
//  Rule.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 21.06.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import Foundation

public protocol Rule {
   
    func validate(_ value: String) -> Bool
   
    func errorMessage() -> String
}
