//
//  AppDelegate.swift
//  DataFetch
//
//  Created by Lee Sangoroh on 17/11/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if let tabBarController = window?.rootViewController as? UITabBarController {
            ///getting reference of the main.storyboard file
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            //create view controller
            let vc = storyboard.instantiateViewController(withIdentifier: "NavController")
            ///create a new UITabBarItem object for the new view controller
            vc.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)
            ///add the new vc to tab controller's viewControllers array, which will cause it to appear on the tab bar
            tabBarController.viewControllers?.append(vc)
        }

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

