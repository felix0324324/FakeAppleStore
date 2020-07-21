//
//  AppDelegate.swift
//  TestASKit
//
//  Created by Alvis on 21/7/2020.
//  Copyright © 2020 Alvis. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.setupWindow()
        // self.goToVC()
        return true
    }

    func setupWindow() {
       self.window = UIWindow(frame: UIScreen.main.bounds)
       self.window!.backgroundColor = UIColor.white
       self.window!.rootViewController = MainViewController.init()
       self.window!.makeKeyAndVisible()
    }
    
//    func goToVC() {
//        let aMainViewController = MainViewController()
//        aMainViewController.view.backgroundColor = .purple
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
//            NavManager.getRootNav()?.pushViewController(aMainViewController, animated: false)
//        })
//    }
}


