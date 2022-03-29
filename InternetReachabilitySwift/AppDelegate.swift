//
//  AppDelegate.swift
//  InternetReachabilitySwift
//
//  Created by Santhosh K on 29/03/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var reachability: Reachability?
    var isReachable: Bool = false
    var ignoreApiCall: Bool = true
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.startMonitoring()
        return true
    }

}

//MARK:- Reachbility
extension AppDelegate {
    func stopMonitoring() {
        reachability?.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: ReachabilityChangedNotification, object: reachability)
    }
    
    func startMonitoring() {
        // first time ignore
        reachability = Reachability()
        if let reachability = reachability {
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(self.reachabilityChanged),
                                                   name: ReachabilityChangedNotification,
                                                   object: reachability)
            do {
                try reachability.startNotifier()
            } catch {
                print("Could not start reachability notifier")
            }
        }
    }
    
    @objc func reachabilityChanged(notification: Notification) {
        if let reachability = notification.object as? Reachability {
            switch reachability.currentReachabilityStatus {
            case .notReachable:
                isReachable = false
                ApiManager.sharedInstance.showOfflineError()
            case .reachableViaWiFi, .reachableViaWWAN:
                isReachable = true
                ApiManager.sharedInstance.removeOfflineError()
                if !ignoreApiCall {
                    startDataSending()
                    //updateOnboardingApi()
                }
            }
            ignoreApiCall = false
        }
    }
    
    func startDataSending() {
        DispatchQueue.main.async {
            print("ApiManager.sharedInstance.isUserLoggedIn() {")
            print(" ByodDeviceManager.shared().inProgress = false")
            print("ByodDeviceManager.shared().startSendingData()")
            print("ByodDeviceManager.shared().reestablishConnection()")
            //}
        }
    }
    
    
}

extension AppDelegate {
    // MARK: UISceneSession Lifecycle
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}
