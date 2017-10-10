//
//  AppDelegate.swift
//  VideoQuickStart
//
//  Copyright © 2015-2017 Twilio, Inc. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
      didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    registerForPushNotifications()
    return true
  }
  func registerForPushNotifications() {
    if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            
            guard granted else { return }
            self.getNotificationSettings()
            print("ssss")
        }
    } else {
        // Fallback on earlier versions
    }
  }

  func getNotificationSettings() {
    if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            UIApplication.shared.registerForRemoteNotifications()
        }
    } else {
        // Fallback on earlier versions
    }
  }

  func application(_ application: UIApplication,
                 didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    let tokenParts = deviceToken.map { data -> String in
      return String(format: "%02.2hhx", data)
    }
    
    let token = tokenParts.joined()
    print("Device Token: \(token)")
  }

  func application(_ application: UIApplication,
                 didFailToRegisterForRemoteNotificationsWithError error: Error) {
    print("Failed to register: \(error)")
  }

}

