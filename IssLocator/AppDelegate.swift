//
//  AppDelegate.swift
//  IssLocator
//
//  Created by Minerva Nolasco Espino on 10/05/22.
//

import UIKit
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GMSServices.provideAPIKey("AIzaSyBuOE9HCyH2GKGKLYFf-CFgxqlN83ktH_E")
        return true
    }
}

