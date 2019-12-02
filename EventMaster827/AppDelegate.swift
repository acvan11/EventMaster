//
//  AppDelegate.swift
//  EventMaster827
//
//  Created by mac on 9/30/19.
//  Copyright © 2019 mac. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure() // init firebase
        Database.database().isPersistenceEnabled = true //handle temporary network outages
        
        return true
    }



    func applicationWillTerminate(_ application: UIApplication) {
        
    }


}

