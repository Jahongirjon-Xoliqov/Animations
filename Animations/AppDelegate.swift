//
//  AppDelegate.swift
//  Animations
//
//  Created by Administrator on 14/03/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.rootViewController = Friday.coordinator.createContainer(with: BubbleViewController())
        window?.makeKeyAndVisible()
        
        return true
    }

}

