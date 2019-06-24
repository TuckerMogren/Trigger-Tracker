//
//  AppDelegate.swift
//  Trigger Tracker
//
//  Created by Tucker Mogren on 1/28/19.
//  Copyright © 2019 TuckerMogren. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    //Global Vars
    var window: UIWindow?
    var fireBaseNoSQLDB: Firestore?
    var fireBaseNoSQLDBDocumentRef: DocumentReference?
    var fireBaseStorage: Storage?
    var fireBaseAuth: Auth?
    

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        fireBaseStorage = Storage.storage()
        fireBaseNoSQLDB = Firestore.firestore()
        fireBaseNoSQLDBDocumentRef = nil
        fireBaseAuth = Auth.auth()
        

        return true
    }
    
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
        
        //Will sign the user out or throw a console error if firebase is unable to log the user out
        //Reference : https://learnappmaking.com/userdefaults-swift-setting-getting-data-how-to/
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "lastStateOfSettingsButton")
        {
           logOutAndReturnToLogInScreenWhenEnteringBackground()
        }
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits
        
        
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.

    
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        
        
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    /*
     * Function Name: logOutAndReturnToLogInScreenWhenEnteringBackground()
     * Will log the user out and return to login screen when entering background.
     * Tucker Mogren; 6/18/19
     * Referenced: https://stackoverflow.com/questions/27954126/how-return-to-the-app-login-screen-when-resuming-an-app-from-background
     */
    private func logOutAndReturnToLogInScreenWhenEnteringBackground()
    {
        
        do {
            try fireBaseAuth?.signOut()
            //If the user is loged out successfully, the application will segue to the login screen.
            if fireBaseAuth?.currentUser == nil
            {
                let storyboard = UIStoryboard(name: "AppHomeDashboard", bundle: nil)
                let rootViewController = storyboard.instantiateViewController(withIdentifier: "welcomeVC") as! ViewWelcomeDashboard
                
                
                self.window?.rootViewController?.dismiss(animated: false, completion: {
                    if self.window != nil
                    {
                        self.window!.rootViewController = rootViewController
                    }
                })
            }
        }catch let signOutError as NSError {
            print("ERROR: Unable to sign user out when the application is entering the background. Error at \(signOutError)")
        }
        

    }

    

}

