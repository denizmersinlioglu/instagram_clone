//
//  Module.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 21.06.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class Module {
    class func injectDependecies(container: Container){
        #if MOCK
//        container.register(WebService.self){_ in MockWebService()}
//        container.register(ClientSession.self){_ in MockClientSession()}
        print("Its is a mock")
        #else
//        container.register(WebService.self){_ in WebServiceImp()}
//        container.register(ClientSession.self){_ in ClientSessionImp()}
        print("Not a mock")
        #endif
    }
}
