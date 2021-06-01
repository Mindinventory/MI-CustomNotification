//
//  UIApplication+CustomNotification.swift
//  CustomNotification
//
//  Created by Riddhi Patel on 31/05/21.
//

import UIKit
import Firebase

extension AppDelegate:UNUserNotificationCenterDelegate,MessagingDelegate{
    //MARK: NOTIFICATION CONFIGURATION
    func NotificationConfiguration(_ application: UIApplication){
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self
          Messaging.messaging().delegate = self
          Messaging.messaging().isAutoInitEnabled = true
          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        } else {
          let settings: UIUserNotificationSettings =
          UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }
        
        //MARK: DEFINE CATEGRORY ID FOR GEETING AND PROCESSING CUSTOM NOTIFICATION
        
        let openBoardAction = UNNotificationAction(identifier: UNNotificationDefaultActionIdentifier, title: "Open Board", options: UNNotificationActionOptions.foreground)
        let contentAddedCategory = UNNotificationCategory(identifier: "CATID!", actions: [openBoardAction], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "", options: .customDismissAction)
        UNUserNotificationCenter.current().setNotificationCategories([contentAddedCategory])

        application.registerForRemoteNotifications()
    }
    
    //MARK: TOKEN REGISTRATION FOR FIREBASE NOTIFICATION
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")
      let dataDict:[String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
    }
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      Messaging.messaging().apnsToken = deviceToken
    }

}
