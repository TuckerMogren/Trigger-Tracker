/*
 * Name: ViewPhotoGallery
 * Description: Code for photo gallery.
 * Author/Date: Tucker J. Mogren 3/11/19
 * References:
 */
import UIKit
import Firebase
import FirebaseAuth

class ViewPhotoGallery: UIViewController {
    
     @IBOutlet weak var menuButton: UIBarButtonItem!
    
    
     let db = Firestore.firestore() //creates instance of the firebase firestone noSQL database.
    //Will have to worry about firebase and timestamps
    
    
    
    /*
     * Function Name: viewDidLoad()
     * When the view controller loads this code is executed.
     * Tucker Mogren; 3/11/19
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenus()
        customizeNavBar()
        // Do any additional setup after loading the view.
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
     * Function Name: readDatabase
     * Function will display data in database for user
     * Tucker Mogren; 3/12/19
     * Reference: https://firebase.google.com/docs/firestore/quickstart
     */
    private func readDatabase () {
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
    /*
     * Function Name: sendDataToDatabase
     * Function will send specific static data to the database when called.
     * Tucker Mogren; 3/11/19
     * Reference: https://firebase.google.com/docs/firestore/quickstart
     */
    private func sendDataToDatabase (fName:String, lName:String){
        

        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            "firstName":fName,
            "lastName":lName,
            "birthDate":"03122019",
            "uid": Auth.auth().currentUser?.uid as Any
        ]){ err in
            if let err = err {
                print("Error adding document: \(err)")
            }else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
    }
    
    /*
     * Function Name: buttonPushToSendDatabaseAction
     * Will test send data to the database to make sure the actions of sending data to the database works and is set up properly.
     * Tucker Mogren; 3/11/19
     */
    @IBAction func buttonPushToSendDatabaseAction(_ sender: Any) {
        print("Button has been pressed.")
        sendDataToDatabase(fName: "James", lName: "Mogren")
        //print("---------Displaying Data--------------")
        readDatabase()
        
        
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
