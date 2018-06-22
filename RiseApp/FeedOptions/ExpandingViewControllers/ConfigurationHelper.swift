//
//  ConfigurationHelper.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 22.06.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import Foundation

internal func Init<Type>(_ value: Type, block: (_ object: Type) -> Void) -> Type {
    block(value)
    return value
}
