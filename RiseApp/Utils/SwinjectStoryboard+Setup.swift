//
//  SwinjectStoryboard+Setup.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 21.06.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import SwinjectStoryboard


extension SwinjectStoryboard {
    @objc class func setup() {
//        defaultContainer.storyboardInitCompleted(SplashScreenViewController.self){ r, c in }
//        defaultContainer.storyboardInitCompleted(LaunchViewController.self) { r, c in
//            c.ws = r.resolve(WebService.self)
//        }
//        defaultContainer.storyboardInitCompleted(FollowingsTableViewController.self) { r, c in
//            c.ws = r.resolve(WebService.self)
//        }
//        defaultContainer.storyboardInitCompleted(FollowersTableViewController.self) { r, c in
//            c.ws = r.resolve(WebService.self)
//        }
//        defaultContainer.storyboardInitCompleted(FollowRequestTableViewController.self) { r, c in
//            c.ws = r.resolve(WebService.self)
//        }
//        defaultContainer.storyboardInitCompleted(AddCreditCardTableViewController.self) { r, c in
//            c.ws = r.resolve(WebService.self)
//        }
//        defaultContainer.storyboardInitCompleted(AddCreditCardTableViewController.self) { r, c in
//            c.clientSession = r.resolve(ClientSession.self)
//        }
        Module.injectDependecies(container: defaultContainer)
    }
}
