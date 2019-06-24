/*
 * Name: ViewChangePassword
 * Description: Form that will allow the user to change their password.
 * Author/Date: Tucker J. Mogren/ 6/22/19
 * References: 
 */
import UIKit
import Firebase
class ViewChangePassword: UIViewController {

    @IBOutlet weak var oldPasswordTextFieldOutlet: UITextField!
    @IBOutlet weak var newPassword1xTextFieldOutlet: UITextField!
    @IBOutlet weak var newPassword2xTextFieldOutlet: UITextField!
    
    let userAuth = (UIApplication.shared.delegate as! AppDelegate).fireBaseAuth
    
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
        if ((newPassword1xTextFieldOutlet.text == newPassword2xTextFieldOutlet.text) && (oldPasswordTextFieldOutlet.text != newPassword1xTextFieldOutlet.text)  && newPassword1xTextFieldOutlet.text!.count >= 8)
        {
            //TODO:
            //1. Check to see if the old password matches the old password on record
            let userCredential = EmailAuthProvider.credential(withEmail: ((userAuth?.currentUser?.email!)!), password: ((self.oldPasswordTextFieldOutlet?.text!)!))
            userAuth?.currentUser?.reauthenticateAndRetrieveData(with: userCredential, completion: { (AuthDataResult, Error) in
                if let error = Error{
                    //Throw an error if the user can not be reauthenicating, indicating the password is incorrect
                    let alert = UIAlertController(title: "Invalid Password", message: "Old password is invalid", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    print("ERROR: Could not reauthenticate user. Error Message \(error)")
                }else{
                    //User was reauthed, password the user entered is correct
                    self.userAuth?.currentUser?.updatePassword(to: self.newPassword1xTextFieldOutlet.text!, completion: { (Error) in
                        if let error = Error{
                            //if the password chould not be changed, display error to console and alert the user
                            print("Error changing password \(error)")
                            let alert = UIAlertController(title: "Error", message: "Password change unsuccessful.", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }else{
                            //if password could be changed, tell the user, log them out, and return to login screen
                            let alert = UIAlertController(title: "Sucess!", message: "Password changed.", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "Log Me Out", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
                                print("Log Me Out choice pressed...Loging out and returning to login screen.")
                                self.logOutAndReturnToLogInScreenWhenPasswordIsChanged()
                            }))
                            self.present(alert, animated: true, completion: nil)
                        }
                    })
                    
                }
            })
            
        }else{
            //either new passwords dont match or the old password and the new password are the same
            //TODO:
            //1. Throw alart and tell the user that either their passwords dont match
            //Or that their new password is not different then their old one
            //Or the password is not long enough
            let alert = UIAlertController(title: "Invalid Login", message: "New passwords do not match, or you reused your old password, or your new password is not long enough.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    /*
     * Function Name: logOutAndReturnToLogInScreenWhenEnteringBackground()
     * Will log the user out and return to login screen when the password is changed.
     * Tucker Mogren; 6/23/19
     * Referenced: https://stackoverflow.com/questions/27954126/how-return-to-the-app-login-screen-when-resuming-an-app-from-background
     */
    private func logOutAndReturnToLogInScreenWhenPasswordIsChanged()
    {
        
        do {
            try userAuth?.signOut()
            //If the user is loged out successfully, the application will segue to the login screen.
            if userAuth?.currentUser == nil
            {
                let storyboard = UIStoryboard(name: "AppHomeDashboard", bundle: nil)
                let rootViewController = storyboard.instantiateViewController(withIdentifier: "welcomeVC") as! ViewWelcomeDashboard
                present(rootViewController, animated: true, completion: nil)
            }
        }catch let signOutError as NSError {
            print("ERROR: Unable to sign user out after the password was changed. Error at \(signOutError)")
        }
        
        
    }

    
}
