//
//  AppDelegate.swift
//  Family
//
//  Created by Bharat Mediratta on 9/11/16.
//  Copyright © 2016 Bharat Mediratta. All rights reserved.
//
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        Debug.print("application didFinishLaunchingWithOptions")

        let api_key = NSBundle.mainBundle().objectForInfoDictionaryKey("GOOGLE_MAPS_API_KEY") as! String
        GMSServices.provideAPIKey(api_key)

        return true
    }

    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        Debug.print("application didReceiveRemoteNotification")
        tbc().startLocationTracking(.High) {
            Debug.print("One high cost location response received - going back to low cost now")
            self.tbc().startLocationTracking(.Low) {
                // Debug.print("Low cost location response received (post notification)")
            }
        }
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
        Debug.print("applicationWillResignActive")
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        Debug.print("applicationDidEnterBackground")
        tbc().startLocationTracking(.Low) {
            // Debug.print("Low cost location response received")
        }
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
        Debug.print("applicationWillEnterForeground")
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        Debug.print("applicationDidBecomeActive")
        tbc().startLocationTracking(.High) {
            // Debug.print("High cost location response received")
        }
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        Debug.print("applicationWillTerminate")
    }
    
    func tbc() -> TabBarController {
        return window?.rootViewController as! TabBarController
    }
}

