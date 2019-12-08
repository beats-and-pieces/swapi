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
        
        window = UIWindow(frame: UIScreen.main.bounds)
        // (2)
        window?.rootViewController = SWAssembly.getViewController()
        // (3)
        window?.makeKeyAndVisible()
        
        let networkManager = SWNetworkManager()
        networkManager.getData()
        return true
    }
    
}

