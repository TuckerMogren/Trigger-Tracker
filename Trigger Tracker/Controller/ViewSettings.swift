/*
 * Class Name: ViewSettings
 * For the Settings view when you are logged into the app.
 * References: https://www.youtube.com/watch?v=rafJcqqyS1E&feature=youtu.be
 * Tucker Mogren; 2/9/19
 */
import UIKit

class ViewSettings: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    let defaults = UserDefaults.standard
    @IBOutlet weak var settingsSwitchBackgroundLogOut: UISwitch!


    /*
     * Function Name: settingsSwitchToggledUpdateUserDefaults(_ sender: Any)
     * Will keep the settings on the settins page the same in between app sessions.
     * Tucker Mogren; 6/19/19
     */
    @IBAction func settingsSwitchToggledUpdateUserDefaults(_ sender: Any)
    {
        preserveStateOfSettingSwitchesBetweenSessions()
    }

    /*
     * Function Name: preserveStateOfSettingSwitchesBetweenSessions()
     * Will keep the settings on the settins page the same in between app sessions.
     * Tucker Mogren; 6/19/19
     */
    private func preserveStateOfSettingSwitchesBetweenSessions()
    {
        defaults.set(settingsSwitchBackgroundLogOut.isOn, forKey: "lastStateOfSettingsButton")
    }
    /*
     * Function Name: viewDidLoad()
     * When the view controller loads this code is executed.
     * Tucker Mogren; 2/9/19
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        customizeNavBar()
        self.settingsSwitchBackgroundLogOut.setOn(defaults.bool(forKey: "lastStateOfSettingsButton"), animated: true)

    }

    /*
     * Function Name: sideMenus()
     * Shows the side bar controller.
     * Tucker Mogren; 2/9/19
     */
    private func sideMenus() {

        if revealViewController() != nil {

            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = 275

        }
    }

    /*
     * Function: customizeNavBar()
     * Will allow for the top naviagtion bar to be customized
     * Tucker Mogren; 2/9/19
     */
    private func customizeNavBar() {


        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1960784314, green: 0.3215686275, blue: 1, alpha: 1)

        navigationController?.navigationBar.titleTextAttributes = convertToOptionalNSAttributedStringKeyDictionary([NSAttributedString.Key.foregroundColor.rawValue: UIColor.white])


    }

}
/*
 * FilePrivate Func: convertToOptionalNSAttributedStringKeyDictionary
 * Helper function inserted by Swift 4.2 migrator.
 * Tucker Mogren; 2/9/19
 */

fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
    guard let input = input else { return nil }
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
