//
//  AppDelegate.swift
//  RiseApp
//
//  Created by Deniz Mersinlioğlu on 21.06.2018.
//  Copyright © 2018 ArcheTech. All rights reserved.
//

import UIKit
import Firebase
import Swinject
import SwinjectStoryboard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let container = SwinjectStoryboard.defaultContainer

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        if(UserDefaults.standard.bool(forKey: "UITest")){
            uitest(window: window)
        }else{
            let storyboard = SwinjectStoryboard.create(name: "Main", bundle: nil, container: container)
            window.rootViewController = storyboard.instantiateInitialViewController()
        }
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    private func uitest(window:UIWindow){
        
        if let storyboardName = UserDefaults.standard.string(forKey: "StoryboardName"){
            let storyboard = SwinjectStoryboard.create(name: storyboardName, bundle: nil, container:container)
            
            if let viewControllerIdentifier = UserDefaults.standard.string(forKey: "StoryboardID"){
                let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier)
                
                if (viewController.navigationItem.title != nil) && !(viewController is UINavigationController){
                    let navigationController = UINavigationController.init(rootViewController: viewController)
                    window.rootViewController = navigationController
                }else{
                    window.rootViewController = viewController
                }
            }else{
                window.rootViewController = storyboard.instantiateInitialViewController()
            }
        }
    }

}

