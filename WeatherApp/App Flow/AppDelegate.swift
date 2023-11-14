//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Rahul on 13/11/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let view = ForecastListModule().build()
        window?.rootViewController = view
        window?.makeKeyAndVisible()
        return true
    }

}

