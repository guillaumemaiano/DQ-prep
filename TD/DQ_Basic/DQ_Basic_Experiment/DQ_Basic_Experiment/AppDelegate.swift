//
//  AppDelegate.swift
//  DQ_Basic_Experiment
//
//  Created by guillaume MAIANO on 18/12/2020.
//

import UIKit
//import Dri
import DriveKitCommonUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


//00002a24-0000-1000-8000-00805f9b34fb
    // 0X11-46-FE-00-00-84-DF-C8
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let center = UNUserNotificationCenter.current()
        // tell the sytem which notifs we'd like to use
        center.requestAuthorization(options:[.alert, .sound], completionHandler: {_,_ in})
        //DriveKit.shared.initialize()
        DriveKitUI.shared.initialize()
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

