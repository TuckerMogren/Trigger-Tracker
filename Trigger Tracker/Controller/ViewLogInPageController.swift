/*
 * Name: ViewLogInPageController
 * Description: Code for storyboard interactions
 * Author/Date: Tucker J. Mogren/ 1/23/2019
 * References: https://medium.com/@ashikabala01/how-to-build-login-and-sign-up-functionality-for-your-ios-app-using-firebase-within-15-mins-df4731faf2f7
 */

import UIKit
class ViewLogInPageController: UIViewController
{
    
    //need to add firebase reference

    //Class global vars for fields that gather data
    //First two are for LogIn
    @IBOutlet weak var eMailTextFieldLogInOutlet: UITextField!
    @IBOutlet weak var passwordTextFieldLogInOutlet: UITextField!
    @IBOutlet weak var saveEMailSwitchOutlet: UISwitch!
    let defaults = UserDefaults.standard
    
    /*
     * Function Name: viewDidLoad()
     * Called after the VC is loaded into memory.
     * Tucker Mogren; 2/27/19
     */
    override func viewDidLoad() {
        //will set the switch to the result of the saved value of defaults.bool
        self.saveEMailSwitchOutlet.setOn(defaults.bool(forKey: "lastStateOfButton"), animated: true)
        if self.saveEMailSwitchOutlet.isOn
        {
            //sets savedEMail equal to the stored value of the last email.
            let savedEMail = defaults.string(forKey: "lastStateOfEMailTextField") ?? "error"
            eMailTextFieldLogInOutlet.text = savedEMail
            
        }
    }
    
    /*
     * Function Name: preserveStateOfSwitchBetweenAppSessions()
     * Will be called to save the state of the switch between app sessions.
     * Reference: https://medium.com/@nimjea/userdefaults-in-swift-4-d1a278a0ec79
     * Tucker Mogren; 2/27/19
     */
    func preserveStateOfSwitchBetweenAppSessions()
    {
        defaults.set(saveEMailSwitchOutlet.isOn, forKey: "lastStateOfButton")
    }
    
    /*
     * Function Name: preserveStateOfEMailBetweenAppSessions()
     * Will be called to save the email username between app sessions when switch is toggled.
     * Reference: https://medium.com/@nimjea/userdefaults-in-swift-4-d1a278a0ec79
     * Tucker Mogren; 2/27/19
     */
    func preserveStateOfEMailBetweenAppSessions()
    {
        defaults.set(eMailTextFieldLogInOutlet.text, forKey: "lastStateOfEMailTextField")
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
        let userAuth = (UIApplication.shared.delegate as! AppDelegate).fireBaseAuth
        
        
        let eMailTextEntryLogIn: String = eMailTextFieldLogInOutlet.text!
        let passwordTextEntryLogIn: String = passwordTextFieldLogInOutlet.text!
        print("Email is: \(eMailTextEntryLogIn) and password is: \(passwordTextEntryLogIn).")
        
        //will save the last state of the switch and email.
        preserveStateOfSwitchBetweenAppSessions();
        preserveStateOfEMailBetweenAppSessions()
        
        var loginCount = 0
        userAuth?.signIn(withEmail: eMailTextEntryLogIn, password: passwordTextEntryLogIn) { (user, error) in
            if (error == nil && user != nil)
            {
                self.performSegue(withIdentifier: "accountLogInGoTo", sender: self)
            }else{
                print("/n/n/n/nERROR: Log-in failed \(error!.localizedDescription).")
                self.showAlertIncorrectLogin()
                loginCount = loginCount + 1
                print("Password has been entered \(loginCount) times.")
                //Add login count and forgot password option after 5 incorrect password attepmts;
            }
        }
        if loginCount == 5{
            self.
        }
    }

}
