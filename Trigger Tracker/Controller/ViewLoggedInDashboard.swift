/*
 * Name: ViewLoggedInDashboard
 * Description: Code for storyboard interactions
 * Author/Date: Tucker J. Mogren/ 2/3/19
 * References:
 */

import UIKit
import Firebase

class ViewLoggedInDashboard: UIViewController{
    
    /*
     * Function Name: viewDidLoad()
     * Will terminate Func runs after the view controller is loaded.
     * Tucker Mogren; 2/5/19
     */
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
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
        let storyboard = UIStoryboard(name: "AppHomeDashboard", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: "Welcome Screen")
        self.present(newVC, animated: true, completion: nil)
        
    }
}
