/*
 * Name: ViewPhotoGallery
 * Description: Code for photo gallery.
 * Author/Date: Tucker J. Mogren 3/11/19
 * References:
 */
import UIKit
import FirebaseFirestore
import FirebaseAuth

class ViewPhotoGallery: UITableViewController {
    
    var data = [CellData]()
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Custom") as! CustomTableViewCell
        cell.mainImage = data[indexPath.row].image
        cell.message = data[indexPath.row].notes
        return cell
        
        
    }
    
    
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    let customSlideBarClassInstance = CustomSlideBar()
    
    
     let db = Firestore.firestore() //creates instance of the firebase firestone noSQL database.
    //Will have to worry about firebase and timestamps

    /*
     * Function Name: viewDidLoad()
     * When the view controller loads this code is executed.
     * Tucker Mogren; 3/11/19
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        data = [CellData.init(image: #imageLiteral(resourceName: "Sam Regalia"), notes: "This is a test.")]
        
        
        //tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "Custom")
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
        db.collection("users").whereField("user_ID", isEqualTo: (Auth.auth().currentUser?.uid)!).getDocuments { (Snapshot, error) in
            if error != nil
            {
                print(error!)
            }else{
                for document in (Snapshot?.documents)! {
                    if let firstName = document.data()["firstName"] as? String {
                        print(firstName)
                    }
                }
            }
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

