//
//  AppDelegate.swift
//  FoodDelivery
//
//  Created by imran shaik on 10/04/21.
//

import UIKit
import CoreLocation


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    let window: UIWindow? = nil
    let api_Key = "4feaa2167c4dc6beadf629319423bd4b"
    let locationManager = CLLocationManager()
    let constLocationChanged = "LocationChanged"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.checkUserLocationPermission()
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


}
extension UIApplication {
    
    class func appInstance() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        
        return controller
    }
}
//MARK:- Location Services
extension AppDelegate: CLLocationManagerDelegate {
    
    func checkUserLocationPermission() {
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            locationManager.delegate = self
            return
            
        case .restricted, .denied:
            let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let actionSettings = UIAlertAction(title: "Settings", style: .default) { (action) -> Void in
                
                UIApplication.shared.open(URL.init(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            }
            
            let alertVC = UIAlertController.init(title: "Location Permission Required", message: "To fetch your nearby restaurants, Kindly allow us to access your location.", preferredStyle: .alert)
            alertVC.addAction(actionCancel)
            alertVC.addAction(actionSettings)
            UIApplication.topViewController()?.present(alertVC, animated: true, completion: nil)
//            UIApplication.topViewController()?.p
            break
            
        case .authorizedAlways, .authorizedWhenInUse:
            self.getLocationForNearbyRestaurants()
            break

        @unknown default:
            return
        }
        
        return
    }
    
    //TODO: Get User Location
    func getLocationForNearbyRestaurants() {
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    //TODO: Location Delegates
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            self.getLocationForNearbyRestaurants()
            break
            
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        manager.stopUpdatingLocation()
        manager.delegate = nil
        
        var latValue = 21.17
        var lngValue = 72.83
        
        if let lastLocation = manager.location {
            
            let locValue = lastLocation.coordinate
            latValue = locValue.latitude
            lngValue = locValue.longitude
        }
        
        var dictLocation = [String : Double]()
        dictLocation["lat"] = latValue
        dictLocation["lng"] = lngValue
        
        //Location Changed
        let locationInfo: [String : [String : Double]] = ["user_location" : dictLocation]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: constLocationChanged), object: nil, userInfo: locationInfo)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("Fail to get Location \(error)")
        
        //Location Changed
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: constLocationChanged), object: nil, userInfo: nil)
    }
}


