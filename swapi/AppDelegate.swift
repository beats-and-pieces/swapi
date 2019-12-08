//
//  AppDelegate.swift
//  swapi
//
//  Created by Anton Kuznetsov on 08/12/2019.
//  Copyright © 2019 Anton Kuznetsov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let assembly = SWAssembly()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = assembly.getViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}

