//
//  AppDelegate.swift
//  2MemoryTest
//
//  Created by Филипп Гурин on 22.07.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let mainVC = MainViewController()
        let navigationController = UINavigationController(rootViewController: mainVC)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

