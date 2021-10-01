//
//  AppDelegate.swift
//  Photo Studio
//
//  Created by Дмитро Мостовий on 26.11.2020.
//

import UIKit
import IQKeyboardManagerSwift
import Bagel

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        

        return true
    }
    
    
}

