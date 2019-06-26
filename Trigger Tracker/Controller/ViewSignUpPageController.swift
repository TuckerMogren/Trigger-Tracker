/*
 * Name: ViewSignUpPageController
 * Description: Code for Sign-Up View Controller
 * Author/Date: Tucker J. Mogren/ 1/29/2019
 */

import UIKit
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

   private func showAlertPasswordDoesntMatch()
    {
        let alert = UIAlertController(title: "Invalid Login", message: "Passwords do not match, Please try again.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
     * Function Name: showAlertPasswordToShort()
     * Will be called when a password is less then 8 digits long.
     * Tucker Mogren; 2/26/19
     * Referenced: https://stackoverflow.com/questions/24022479/how-would-i-create-a-uialertview-in-swift/33340757#33340757
     */
   private func showAlertPasswordToShort()
    {
        let alert = UIAlertController(title: "Invalid Login", message: "Password is less then 8 charaters, Please try again.", preferredStyle: UIAlertController.Style.alert)
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
        let userAuth = (UIApplication.shared.delegate as! AppDelegate).fireBaseAuth
        
        let e_mailEntrySignUp: String = e_MailTextFieldSignUpOutlet.text!
        let password1XSignUp: String = password1xTextFieldSignUpOutlet.text!
        let password2XSignUp: String = password2xTextFieldSignUpOutlet.text!
        
        print("Email is: \(e_mailEntrySignUp), 1x Passowrd is: \(password1XSignUp), and 2x passowrd is: \(password2XSignUp). ")
        
        if(password1XSignUp.count >= 8)
        {
            //will check to see if password is >= 8 digits first.
            if (password1XSignUp == password2XSignUp)
            {
                //Then will check if they match.
                print("TWO STRINGS MATCH: \(password1XSignUp) and \(password2XSignUp)")
                
                //creates new user.
                userAuth?.createUser(withEmail: e_mailEntrySignUp, password: password1XSignUp) { (authResult, error) in
                    if error != nil
                    {
                        print("ERROR: \(error!)")
                    }
                    let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "logInVC")
                    self.present(loginViewController!, animated: true, completion: nil)
                }
                
            }else{
                print("Two strings do not match: \(password1XSignUp) and \(password2XSignUp)")
                showAlertPasswordDoesntMatch()
                
            }
        }else {
            print("Password is two short.")
            showAlertPasswordToShort()
        }
    }
}
