//
//  AppDelegate.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let navigationViewController = UINavigationController()
        navigationViewController.viewControllers = [AuthorizationConfigurator.sharedInstance.configure()]
        self.window = window
        self.window?.rootViewController = navigationViewController
        self.window?.makeKeyAndVisible()
        return true
    }
}

