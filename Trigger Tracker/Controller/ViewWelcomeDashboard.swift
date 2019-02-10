/*
 * Name: ViewWelcomeDashboard
 * Description: Code for storyboard interactions
 * Author/Date: Tucker J. Mogren/ 1/23/2019
 * References: https://medium.com/@ashikabala01/how-to-build-login-and-sign-up-functionality-for-your-ios-app-using-firebase-within-15-mins-df4731faf2f7
 */

import UIKit
import Firebase

class ViewWelcomeDashboard: UIViewController {

    
    
    /*
     * Function Name: viewDidLoad()
     * Called after the view controller is loaded into memory - Per apple documentation: https://developer.apple.com/documentation/uikit/uiviewcontroller/1621495-viewdidload
     * Tucker Mogren; 1/23/19
     */
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

    }
    
    /*
     * Function: signInButtonHomeScreen()
     * Will move the user from the home screen to the sign in screen.
     * Tucker Mogren; 1/23/19
     */
    
    @IBAction func signInButtonHomeScreenAction(_ sender: Any)
    {
        performSegue(withIdentifier: "goToReg", sender: self)
    }
    
    /*
     * Function Name: logInbuttonhomeScreen()
     * Will gather and save the users entry to be passed in for authenication
     * Tucker Mogren; 1/23/19
     */
    
    @IBAction func logInButtonHomeScreenAction(_ sender: Any)
    {
        performSegue(withIdentifier: "goToLogin", sender: self)
    }
    
}
