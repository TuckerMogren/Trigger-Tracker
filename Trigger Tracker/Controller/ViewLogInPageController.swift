/*
 * Name: ViewLogInPageController
 * Description: Code for storyboard interactions
 * Author/Date: Tucker J. Mogren/ 1/23/2019
 * References: https://medium.com/@ashikabala01/how-to-build-login-and-sign-up-functionality-for-your-ios-app-using-firebase-within-15-mins-df4731faf2f7
 */

import UIKit
import Firebase
class ViewLogInPageController: UIViewController
{
    
    //Class global vars for fields that gather data
    //First two are for LogIn
    @IBOutlet weak var eMailTextFieldLogInOutlet: UITextField!
    @IBOutlet weak var passwordTextFieldLogInOutlet: UITextField!
    @IBOutlet weak var saveEMailSwitchOutlet: UISwitch!
    
    
    /*
     * Function Name: viewDidLoad()
     * Called after the VC is loaded into memory.
     * Tucker Mogren; 2/27/19
     */
    override func viewDidLoad() {
        
    }
    
    /*
     * Function Name: saveEmailSwitchAction()
     * Either saves or not email for future session.
     * Tucker Mogren; 2/27/19
     */
    @IBAction func saveEmailSwitchAction(_ sender: Any)
    {
        
        
        
        
        
    }
    
    /*
     * Function Name:showAlertIncorrectLogin()
     * Will be called when either a username and password is unable to be signed in
     * Tucker Mogren; 1/25/19
     * Referenced: https://stackoverflow.com/questions/24022479/how-would-i-create-a-uialertview-in-swift/33340757#33340757
     */
    
    func showAlertIncorrectLogin()
    {
        let alert = UIAlertController(title: "Invalid Login", message: "Username or password incorrect, Please try again.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
     * Function Name: logInButtonAction()
     * Will send users information to Firebase for Authenication.
     * Tucker Mogren; 1/23/19
     * Referenced: https://firebase.google.com/docs/auth/ios/custom-auth
     */
    
    @IBAction func logInButtonAction(_ sender: Any)
    {
        let defaultValue = UserDefaults.standard
        let eMailTextEntryLogIn: String = eMailTextFieldLogInOutlet.text!
        let passwordTextEntryLogIn: String = passwordTextFieldLogInOutlet.text!
        print("Email is: \(eMailTextEntryLogIn) and password is: \(passwordTextEntryLogIn).")
        
        
        Auth.auth().signIn(withEmail: eMailTextEntryLogIn, password: passwordTextEntryLogIn) { (user, error) in
            if (error == nil && user != nil)
            {
       
                self.performSegue(withIdentifier: "accountLogInGoTo", sender: self)
                if self.saveEMailSwitchOutlet.isOn
                {
                defaultValue.set(self.eMailTextFieldLogInOutlet.text, forKey: "eMail")
                defaultValue.synchronize()
                }else {
                    self.eMailTextFieldLogInOutlet.text = ""
                }
                
            }else{
                print("/n/n/n/nERROR: Log-in failed \(error!.localizedDescription).")
                self.showAlertIncorrectLogin()
                //Add login count and forgot password option after 5 incorrect password attepmts;
            }
        }
    }
    /*
     * Function Name: loadSavedEMailDefaults()
     * Will be able to load the default email chosen to be saved.
     * Tucker Mogren; 2/27/19
     */
    func loadSavedEMailDefaults()
    {
        let defaultValue = UserDefaults.standard
        self.eMailTextFieldLogInOutlet.text = defaultValue.object(forKey: "eMail") as? String
        
    }
}
