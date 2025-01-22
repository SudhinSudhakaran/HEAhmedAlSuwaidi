//
//  AppDelegate.swift
//  HEAhmedAlSuwaidi
//
//  Created by Tanura Vittil on 11/17/17.
//  Copyright © 2017 Electronic Village. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var eventdate: String?
    let articleListService = AAAricleListService()
    var eventdatestring: String?
    var pushNotificationReceived = false
    var articlesArray: [AAArticleModel]?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /*Push NOTification*/
        registerForPushNotifications()
        
        //Action after notification received if app was not running
        // Check if launched from notification
        // 1
        if let notification = launchOptions?[.remoteNotification] as? [String: AnyObject] {
            // 2
            let aps = notification["aps"] as! [String: AnyObject]
            //_ = NewsItem.makeNewsItem(aps)
            // 3
            //(window?.rootViewController as? UITabBarController)?.selectedIndex = 1

            eventdate = aps["eventdate"] as? String
            let dictionary = ["name": "Alice"]
            pushNotificationReceived = true
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SomeNotificationAct"), object: dictionary)
            
        }
        /*Push NOTification*/
        
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
        
        application.applicationIconBadgeNumber = 0
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
   /*Push NOTification*/
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
   
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        
        let token = tokenParts.joined()
        print("Device Token: \(token)")
        /*sending the token to the webserver to save in the database*/
        let scriptUrl = "http://www.electronicvillage.org/hea_json_tokeninsert.php?token=\(token)"
        
        let tokenUrl = NSURL(string:scriptUrl);
        let request  = NSMutableURLRequest(url:tokenUrl! as URL);
        request.httpMethod = "GET"
        
        let task1 = URLSession.shared.dataTask(with: request as URLRequest){data,URLResponse,error in
        
        if error != nil
        {
            print ("error=\(String(describing: error))")
        }
        }
        task1.resume()
        
        /*sending the token to the webserver to save in the database*/
        
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    //Action after notification received if app running in the background or foreground
    func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable : Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        let aps = userInfo["aps"] as! [String: AnyObject]
        //_ = NewsItem.makeNewsItem(aps)
        print (aps)
        print ("tanura")
        eventdate = aps["eventdate"] as? String
        
        //NotificationCenter.defaultCenter.postNotificationName("SomeNotification", object:nil)
        let dictionary = ["name": "Alice"]
        pushNotificationReceived = true
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SomeNotificationAct"), object: dictionary)
        
    }
    /*Push NOTification*/

}

