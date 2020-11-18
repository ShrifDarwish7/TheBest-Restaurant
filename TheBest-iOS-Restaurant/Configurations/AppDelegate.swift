//
//  AppDelegate.swift
//  TheBest-iOS-Restaurant
//
//  Created by Sherif Darwish on 10/2/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import IQKeyboardManagerSwift
import SVProgressHUD
import GoogleMaps
import GooglePlaces
import FirebaseMessaging
import MOLH

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    static var standard: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        IQKeyboardManager.shared.enable = true
        GMSServices.provideAPIKey("AIzaSyDBDV-XxFpmbx79T5HLPrG9RmjDpiYshmE")
        GMSPlacesClient.provideAPIKey("AIzaSyDBDV-XxFpmbx79T5HLPrG9RmjDpiYshmE")
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setDefaultAnimationType(.native)
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setCornerRadius(10)
        SVProgressHUD.setMinimumSize(CGSize(width: 75, height: 75))
        SVProgressHUD.setForegroundColor(UIColor(named: "MainColor")!)
        // SVProgressHUD.setBackgroundColor(UIColor.black)
        
        MOLH.shared.activate(true)
        
        if #available(iOS 13.0, *){
            
        }else{
            if AuthServices.instance.isLogged {
                
                let rootViewController: UIWindow = ((UIApplication.shared.delegate?.window)!)!
                if AuthServices.instance.isLogged{
                    let mainStoryboard = UIStoryboard(name: "Main" , bundle: nil)
                    let protectedPage = mainStoryboard.instantiateViewController(withIdentifier: "NavHome") as! UINavigationController
                    rootViewController.rootViewController = protectedPage
                    window!.makeKeyAndVisible()
                }
                
            }
        }
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = self
        
        return true
    }


    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "TheBest_iOS_Restaurant")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate{
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
}

extension AppDelegate: MessagingDelegate{
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("fcmTokenHere",fcmToken)
        UserDefaults.init().set(fcmToken, forKey: "FCM_Token")
    }
}

extension String{
    var localized: String{
        return NSLocalizedString(self, comment: "")
    }
}

extension AppDelegate:  MOLHResetable {
    @available(iOS 13.0, *)
    func swichRoot(){
        let scene = UIApplication.shared.connectedScenes.first
        if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
            if AuthServices.instance.isLogged{
                let mainStoryboard = UIStoryboard(name: "Main" , bundle: nil)
                let protectedPage = mainStoryboard.instantiateViewController(withIdentifier: "NavHome") as! UINavigationController
                sd.window!.rootViewController = protectedPage
                window!.makeKeyAndVisible()
            }
        }
    }
    func reset() {
        if #available(iOS 13.0, *) {
            self.swichRoot()
        }else{
            let rootViewController: UIWindow = ((UIApplication.shared.delegate?.window)!)!
            if AuthServices.instance.isLogged{
                 let mainStoryboard = UIStoryboard(name: "Main" , bundle: nil)
                 let protectedPage = mainStoryboard.instantiateViewController(withIdentifier: "NavHome") as! UINavigationController
                rootViewController.rootViewController = protectedPage
                window!.makeKeyAndVisible()
            }
        }
    }
    static func changeLangTo(_ lang: String){
        MOLHLanguage.setDefaultLanguage("en")
        MOLH.setLanguageTo(lang)
        
        if #available(iOS 13.0, *) {
            let delegate = UIApplication.shared.delegate as? AppDelegate
            delegate!.swichRoot()
        } else {
            MOLH.reset()
        }
    }
}
