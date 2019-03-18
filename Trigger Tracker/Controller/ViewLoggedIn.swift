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
    
    
    var imageData : [tableViewImages] = [tableViewImages]()
    
    /*
     * Function Name: viewDidLoad()
     * When the view controller loads this code is executed.
     * Tucker Mogren; 2/9/19
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        customizeNavBar()
        readDatabase()
        print("Values in the dict are.....")
        testDictValues()
        
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
                print("In the data!")
                for document in (Snapshot?.documents)! {
                    numberOfDocumentsInDataBase = numberOfDocumentsInDataBase + 1
                    if let imageName = document.data()["imageName"] as? String
                    {
                        print("The image name is: \(imageName)")
                        self.imageData[numberOfDocumentsInDataBase].imageName = imageName
                        //TODO: need to convert imageData from a dictionary back to a struct
                    }
                    if let userNotes = document.data()["userNotes"] as? String
                    {
                        print("The user notes are: \(userNotes)")
                        self.imageData[numberOfDocumentsInDataBase].userNotes = userNotes
                    }
                    if let imageDate = document.data()["imageDate"] as? NSDate
                    {
                        print("The image date is: \(imageDate)")
                        self.imageData[numberOfDocumentsInDataBase].photoDate = imageDate
                    }
                    
                    
                    //fill dict. in this scope
                    //TODO: check for duplicates and remove dutplicates before sending data to dict.
                        //1. compare image names between the one in the database and all the ones in the current dict.
                        //1a. if its there, goto the next one
                        //1b. if its not there, add it
                    //use string interpolation to display NSDate to the user in the table view
                    
                    
                }
                print("There are: \(numberOfDocumentsInDataBase) items in the database.")
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
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1019607843, green: 0.4588235294, blue: 0.8196078431, alpha: 1)
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
    
    
    //test function to see what values are in the dict.
    func testDictValues() {
        imageData.forEach { print($0)
        }
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
