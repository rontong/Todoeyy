//
//  AppDelegate.swift
//  Todoeyy
//
//  Created by Ronald Tong on 26/7/18.
//  Copyright © 2018 StokeDesign. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
        
        // Locate the Realm database
        // print(Realm.Configuration.defaultConfiguration.fileURL)

        // Initialize the Realm
        do {
            _ = try Realm()
        } catch {
            print("***Error initializing new realm, \(error)")
        }
        
        return true
    }

    
}


