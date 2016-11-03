//
//  AppDelegate.swift
//  Vomer_iOS9
//
//  Created by MAC  on 22.07.16.
//  Copyright © 2016 MAC . All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //first time permisson for push   dont allow   <>  OK
    func registerForPushNotifications(application: UIApplication) {
        let notificationSettings = UIUserNotificationSettings(
            forTypes: [.Badge, .Sound, .Alert], categories: nil)
        application.registerUserNotificationSettings(notificationSettings)//REMOTE_NOTIFICATION_SIMULATOR_NOT_SUPPORTED_NSERROR_DESCRIPTION
    }
    
        func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        NSURLProtocol.registerClass(MyURLProtocol)
        
        //registerForPushNotifications(application)
        
        return true
}
    
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
    
        /*if notificationSettings.types != .None {
            application.registerForRemoteNotifications()//!!!!!!register in APNs
        }*/
    }
    
    //Error.  if dont register in Push Notificatios server
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
            debugPrint("Filed to register at APNs: \(error.description)")
        
       /* let alert = UIAlertController(title: "Device token from APNs", message: "Error to Get the Device Token from APNs. Error: \(error.description)", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        self.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)*/

    }
    
    
    
    //get device token
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        /*let tokenChar = UnsafePointer<CChar>(deviceToken.bytes)
        var tokenString = ""
        for i in 0..<deviceToken.length{
            tokenString += String(format: "%02.2hhx", arguments: [tokenChar[i]])
        }
        debugPrint("deviceToken: ", tokenString)*/

        
        /*let alert = UIAlertController(title: "Device token from APNs", message: tokenString, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        self.window?.rootViewController?.presentViewController(alert, animated: true, completion: nil)*/
        
            }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

