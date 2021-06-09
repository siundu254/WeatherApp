//
//  AppDelegate.swift
//  WeatherApp
//
//  Created by Kevin Siundu on 05/06/2021.
//

import UIKit
import CoreLocation

@main
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
    
    private var currentLocation: CLLocation?
    private var locationManager: CLLocationManager!
    private let coordinator = AppCoordinator()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupLocationManager()
        coordinator.start()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    // Get user location when the App Launches
    // save the data as variables to User Default
    // we will use user coordinates to fetch current weather data from
    // openweather api
    
    // func to provide user current location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if currentLocation == nil {
            currentLocation = locations.last
            manager.stopMonitoringSignificantLocationChanges()
            
            let locationValue : CLLocationCoordinate2D = manager.location!.coordinate
            
            let defaults = UserDefaults.standard
            defaults.set(locationValue.latitude, forKey: "latitude")
            defaults.set(locationValue.longitude, forKey: "longitude")
            manager.stopUpdatingLocation()            
        } else {
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.requestWhenInUseAuthorization()
            setupLocationManager()
        }
    }
    
    // func to print error if not able to update locations
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error = \(error)")
    }
    
    // setup the func to handle the locationManger
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
    }
}

