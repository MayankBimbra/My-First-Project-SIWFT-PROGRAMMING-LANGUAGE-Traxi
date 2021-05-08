//
//  AppDelegate.swift
//  Traxi
//
//  Created by IOS on 22/03/21.
//

import UIKit
import CoreData
import IQKeyboardManagerSwift
import Firebase
import GoogleSignIn
import FBSDKCoreKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    //Push Notifications
    func registerForPushNotifications(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge]) { (granted, error) in
            print(granted)
        }
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //Push Notifications
        registerForPushNotifications()
        
        // Initialize the Facebook SDK
        ApplicationDelegate.shared.application(application,didFinishLaunchingWithOptions: launchOptions)
        
        
        //Localization
        var ifLangSelected = false
        print(L102Language.currentAppleLanguage())
        for lang in language{
            if lang.code == L102Language.currentAppleLanguage(){
                selectedLanguage = lang
                ifLangSelected = true
            }
        }
        if !ifLangSelected{
            L102Language.setAppleLAnguageTo(selectedLanguage.code)
        }
        L012Localizer.DoTheSwizzling()
        //for launchscreen to open for 1.5 seconds
        Thread.sleep(forTimeInterval: 1.5)
        
        //CoreData
        coreData.shared.getData()
        if coreData.shared.accessToken != ""{
        }
        
        //IQ KeyBoard Manager
        IQKeyboardManager.shared.enable = true
        
        // For Google SignIn
        FirebaseApp.configure()
        GIDSignIn.sharedInstance()?.clientID = "975673038289-k2fvvfolr9gg54hqehpqq3v7d1ktnqh5.apps.googleusercontent.com"
        return true
    }
    // MARK:- Open URL Function For Both FaceBook and Google
    func application(_ app: UIApplication, open url: URL, options:
                        [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
       
        var flag : Bool = false
        if ApplicationDelegate.shared.application(app, open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                  annotation: options[UIApplication.OpenURLOptionsKey.annotation]
        ){ //Url scheme for Facebook
            flag = ApplicationDelegate.shared.application(app,open: url, sourceApplication: options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String,
                                                          annotation: options[UIApplication.OpenURLOptionsKey.annotation])
        }else{
            //Url scheme for Google
            flag = GIDSignIn.sharedInstance().handle(url)
        }
        return flag
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
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "Traxi")
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
