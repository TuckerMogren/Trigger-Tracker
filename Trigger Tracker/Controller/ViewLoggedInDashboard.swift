//
//  ViewLoggedInDashboard.swift
//  Trigger Tracker
//
//  Created by Tucker Mogren on 1/29/19.
//  Copyright © 2019 TuckerMogren. All rights reserved.
//

import UIKit
import Firebase

class ViewLoggedInDashboard: UIViewController {
    
    /*
     * Function Name: logInButtonLogOutAction()
     * Will terminate a login session and allow a user to be logged out correctly.
     * Tucker Mogren; 1/27/19
     */
    @IBAction func logInButtonLogOutAction(_ sender: Any)
    {
        let firebaseAuthLogOut = Auth.auth()
        do {
            try firebaseAuthLogOut.signOut()
            
        }catch let signOutError as NSError {
            print("ERROR: Singout \(signOutError)")
        }
        
        
        performSegue(withIdentifier: "goToWelcomeScreenAfterLogOut", sender: self)
    }
}
