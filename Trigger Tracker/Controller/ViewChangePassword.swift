//
//  ViewChangePassword.swift
//  Trigger Tracker
//
//  Created by Tucker Mogren on 6/20/19.
//  Copyright © 2019 TuckerMogren. All rights reserved.
//

import UIKit

class ViewChangePassword: UIViewController {

    @IBOutlet weak var oldPasswordTextFieldOutlet: UITextField!
    @IBOutlet weak var newPassword1xTextFieldOutlet: UITextField!
    @IBOutlet weak var newPassword2xTextFieldOutlet: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    /*
     * Function Name: updatePasswordButtonAction(_ sender: Any)
     * Will update the users password when the button is presse
     * Reference:
     * Tucker Mogren; 6/22/19
     */
    @IBAction func updatePasswordButtonAction(_ sender: Any)
    {
        if ((newPassword1xTextFieldOutlet.text == newPassword2xTextFieldOutlet.text) && (oldPasswordTextFieldOutlet.text != newPassword1xTextFieldOutlet.text))
        {
            
            //TODO:
            //1. Check to see if the old password matches the old password on record
            //2. check to make sure the new password meets the min password req (8 charaters or more)
            //3. Change the password
            //3.A if the password is changed successfully: Tell user (via alert) and then Log the user out and send them back to the login screen
            //3.B. if it is not, throw error and tell user
            //4 Done
        
        }else{
            
            //TODO:
            //1. Throw alart and tell the user that either there passwords dont match
            //Or that their new password is not different then their old one
            //2. Done
    
        }
    }
    
}
