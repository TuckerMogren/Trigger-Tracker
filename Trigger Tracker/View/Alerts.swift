/*
 * Name: Alerts
 * Description: All alerts will be created in this class
 * Author/Date: Tucker J. Mogren/ 1/27/2019
 */

import UIKit
/*
 * Function Name:showAlertIncorrectLogin()
 * Will be called when either a username and password is unable to be signed in
 * Tucker Mogren; 1/25/19
 * Referenced: https://stackoverflow.com/questions/24022479/how-would-i-create-a-uialertview-in-swift/33340757#33340757
 */
class Alerts: UIViewController{
    

    func showAlertIncorrectLogin()
    {
        let alert = UIAlertController(title: "Invalid Login", message: "Username or password incorrect, Please try again.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }

    /*
     * Function Name: showAlertPasswordDoesntMatch()
     * Will be called when either a username and password is unable to be signed in
     * Tucker Mogren; 1/25/19
     * Referenced: https://stackoverflow.com/questions/24022479/how-would-i-create-a-uialertview-in-swift/33340757#33340757
     */

    func showAlertPasswordDoesntMatch()
    {
        let alert = UIAlertController(title: "Invalid Login", message: "Passwords do not match, Please try again.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
