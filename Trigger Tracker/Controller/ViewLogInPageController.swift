/*
 * Name: ViewLogInPageController
 * Description: Code for storyboard interactions
 * Author/Date: Tucker J. Mogren/ 1/23/2019
 * References: https://medium.com/@ashikabala01/how-to-build-login-and-sign-up-functionality-for-your-ios-app-using-firebase-within-15-mins-df4731faf2f7
 */

import UIKit
class ViewLogInPageController: UIViewController
{
    

    //Class global vars for fields that gather data

    @IBOutlet weak var eMailTextFieldLogInOutlet: UITextField!
    @IBOutlet weak var passwordTextFieldLogInOutlet: UITextField!
    @IBOutlet weak var saveEMailSwitchOutlet: UISwitch!
    @IBOutlet weak var logInButtonOutlet: CustomShapeButton!
    @IBOutlet weak var forgotPasswordBtnOutlet: CustomShapeButton!
    let userAuth = (UIApplication.shared.delegate as! AppDelegate).fireBaseAuth
    var loginCount = 0
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
    
    func showAlertIncorrectLogin(passwordApts: Int )
    {
        let maxPasswordAtps = 3
        let alert = UIAlertController(title: "Invalid Login", message: "Username or password incorrect. You have \(maxPasswordAtps - passwordApts) remaining.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
                if self.loginCount == maxPasswordAtps{
                    self.logInButtonOutlet.isHidden = true
                    self.forgotPasswordBtnOutlet.isHidden = false

                }
            }))
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
     * Function Name: forgotPasswordBtnAction(_ sender: Any)
     * Will send the user an email with instructions on how they can reset their password
     * Tucker Mogren; 6/24/19
     * Referenced: https://firebase.google.com/docs/auth/web/manage-users#send_a_password_reset_email
     */
    @IBAction func forgotPasswordBtnAction(_ sender: Any)
    {
        //will send the email in the apps language
        userAuth?.useAppLanguage()
        userAuth?.sendPasswordReset(withEmail: (self.eMailTextFieldLogInOutlet.text)!, completion: { (Error) in
            if let err = Error {
                print("ERROR: Could not send password reset email: \(err)")
                let alertIf = UIAlertController(title: "Could not send email", message: "Password reset email could not be sent, try again later.", preferredStyle: UIAlertController.Style.alert)
                alertIf.addAction(UIAlertAction(title: "Try Again.", style: UIAlertAction.Style.default, handler: nil))
                self.present(alertIf, animated: true, completion: nil)
            }else{
                //alert user success
                let alertElse = UIAlertController(title: "Email sent!", message: "Check your email inbox for instructions!", preferredStyle: UIAlertController.Style.alert)
                alertElse.addAction(UIAlertAction(title: "Ok.", style: UIAlertAction.Style.default, handler: nil))
                self.present(alertElse, animated: true, completion: nil)
            }
        })
        
    }
    /*
     * Function Name: logInButtonAction()
     * Will send users information to Firebase for Authenication.
     * Tucker Mogren; 1/23/19
     * Referenced: https://firebase.google.com/docs/auth/ios/custom-auth
     */
    @IBAction func logInButtonAction(_ sender: Any)
    {

        let eMailTextEntryLogIn: String = eMailTextFieldLogInOutlet.text!
        let passwordTextEntryLogIn: String = passwordTextFieldLogInOutlet.text!
        //will save the last state of the switch and email.
        preserveStateOfSwitchBetweenAppSessions()
        preserveStateOfEMailBetweenAppSessions()
        userAuth?.signIn(withEmail: eMailTextEntryLogIn, password: passwordTextEntryLogIn) { (user, error) in
            if (error == nil && user != nil)
            {
                self.performSegue(withIdentifier: "accountLogInGoTo", sender: self)
            }else{
                print("/n/n/n/nERROR: Log-in failed \(error!.localizedDescription).")
                self.loginCount = self.loginCount + 1
                self.showAlertIncorrectLogin(passwordApts: self.loginCount)
            }
        }
    }
}
