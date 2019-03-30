/*
 * Class Name: ViewLoggedIn
 * For the welcome screen when you first log into the app.
 * References: https://www.youtube.com/watch?v=rafJcqqyS1E&feature=youtu.be
 * Tucker Mogren; 2/9/19
 */
import UIKit
class ViewLoggedIn: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var logOutButton: UIBarButtonItem!
    
    var imageData = tableViewImages()
    
    /*
     * Function Name: viewDidLoad()
     * When the view controller loads this code is executed.
     * Tucker Mogren; 2/9/19
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        customizeNavBar()
        
    }
    
    /*
     * Function Name: readDatabase
     * Function will display data in database for user
     * Tucker Mogren; 3/17/19
     * Reference: https://firebase.google.com/docs/firestore/quickstart
     */
    

    func readDatabase () {
        let db = (UIApplication.shared.delegate as! AppDelegate).fireBaseNoSQLDB
        let userAuth = (UIApplication.shared.delegate as! AppDelegate).fireBaseAuth
        var numberOfDocumentsInDataBase = 0
        
        db?.collection("photoInformation").whereField("userID", isEqualTo: (userAuth?.currentUser?.uid)!).getDocuments { (Snapshot, error) in
           
            if error != nil
            {
                print("ERROR: \(error!)")
            }else{
                for document in (Snapshot?.documents)! {
                    numberOfDocumentsInDataBase = numberOfDocumentsInDataBase + 1
                    let pieceOfDataName = document.get("imageName")
                    let pieceOfDataNotes = document.get("userNotes")
                    let pieceOfDataDate = document.get("imageDate")
                    
                    self.imageData.imageName.append("\(pieceOfDataName!)")
                    self.imageData.userNotes.append("\(pieceOfDataNotes!)")
                    self.imageData.imageDate.append("\(pieceOfDataDate!)")
                }
                
            }
        }
    }
    
    /*
     * Function Name: sideMenus()
     * Shows the side bar controller.
     * Tucker Mogren; 2/9/19
     */
    func sideMenus() {
        
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
    func customizeNavBar() {

        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1960784314, green: 0.3215686275, blue: 1, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = convertToOptionalNSAttributedStringKeyDictionary([NSAttributedString.Key.foregroundColor.rawValue: UIColor.white])
    }
    /*
     * Function Name: logInButtonLogOutAction()
     * Will terminate a login session and allow a user to be logged out correctly.
     * Tucker Mogren; 2/9/19
     */
    @IBAction func logInButtonLogOutAction(_ sender: Any)
    {
        let userAuth = (UIApplication.shared.delegate as! AppDelegate).fireBaseAuth
        
        do {
            try userAuth?.signOut()
            
        }catch let signOutError as NSError {
            print("ERROR: Singout \(signOutError)")
        }
        let storyboard = UIStoryboard(name: "AppHomeDashboard", bundle: nil)
        let newVC = storyboard.instantiateViewController(withIdentifier: "Welcome Screen")
        self.present(newVC, animated: true, completion: nil)
        
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
