/*
 * Name: ViewSignUpPageController
 * Description: Code for Sign-Up View Controller
 * Author/Date: Tucker J. Mogren/ 1/29/2019
 */

import UIKit
import Firebase

class ViewSignUpPageController: UIViewController {
    
    //Last three are for SignUp
    @IBOutlet weak var e_MailTextFieldSignUpOutlet: UITextField!
    @IBOutlet weak var password1xTextFieldSignUpOutlet: UITextField!
    @IBOutlet weak var password2xTextFieldSignUpOutlet: UITextField!



    /*
     * Function Name: showAlertPasswordDoesntMatch()
     * Will be called when either a username and password is unable to be signed in
     * Tucker Mogren; 1/25/19
     * Referenced: https://stackoverflow.com/questions/24022479/how-would-i-create-a-uialertview-in-swift/33340757#33340757
     */

    func showAlertPasswordDoesntMatch()
    {
        let alert = UIAlertController(title: "Invalid Login", message: "Passwords do not match or password is less then 8 charaters, Please try again.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }

    /*
     * Function: createAccountButton()
     * Will sent data to firebase in order to create account
     * Tucker Mogren; 1/23/19
     */

    @IBAction func createAccountButtonAction(_ sender: Any)
    {
        let e_mailEntrySignUp: String = e_MailTextFieldSignUpOutlet.text!
        let password1XSignUp: String = password1xTextFieldSignUpOutlet.text!
        let password2XSignUp: String = password2xTextFieldSignUpOutlet.text!
        
        print("Email is: \(e_mailEntrySignUp), 1x Passowrd is: \(password1XSignUp), and 2x passowrd is: \(password2XSignUp). ")
        
        if ((password1XSignUp == password2XSignUp) && password1XSignUp.count >= 8)
        {
            //first check if less then 8 charaters.
            //then check if the passwords match.
            
            //change alerts.
            
            print("TWO STRINGS MATCH: \(password1XSignUp) and \(password2XSignUp)")
            
            //creates new user.
            Auth.auth().createUser(withEmail: e_mailEntrySignUp, password: password1XSignUp) { (authResult, error) in
                if error != nil
                {
                    print("ERROR: \(error!)")
                }
                let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "logInVC")
                self.present(loginViewController!, animated: true, completion: nil)
                
                
            }
            
        }else{
            print("TWO STRINGS DO NOT MATCH OR are not greater then 8 in length: \(password1XSignUp) and \(password2XSignUp)")
            showAlertPasswordDoesntMatch()
            
        }
        
        
        /*
         * TODO:
         * Check to see if passwords match, make sure passwords are at least 15 charaters long and contain a digit.
         * If everything checks out, send to firebase to create account, and then return them to the login screen to login for the first time
         * Else: Throw an error, asking them to try again.
         */
        
        
        
        
    }
}
