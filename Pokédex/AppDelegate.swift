//
//  AppDelegate.swift
//  Pokédex
//
//  Created by Amanuel Ketebo on 12/14/17.
//  Copyright © 2017 SinCityDev. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupAppearance()
        
        return true
    }
    
    private func setupAppearance() {
        let blackAttribute = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = blackAttribute
        UINavigationBar.appearance().largeTitleTextAttributes = blackAttribute
        UINavigationBar.appearance().barTintColor = Theme.Colors.red
        
    }
}

