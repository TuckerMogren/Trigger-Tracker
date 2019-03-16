/*
 * Name: ViewPhotoGallery
 * Description: Code for photo gallery.
 * Author/Date: Tucker J. Mogren 3/11/19
 * References:
 */
import UIKit
import FirebaseFirestore
import FirebaseAuth

class ViewPhotoGallery: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var data = [CellData]()
    
    @IBOutlet weak var menuButtonOutlet: UIBarButtonItem!

    //Ambigious reference error fixed with reference to: https://stackoverflow.com/questions/33724190/ambiguous-reference-to-member-tableview
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOne", for: indexPath) as! CustomTableViewCell
        
        cell.cellOneImageView.image = UIImage(named: data[indexPath.row].imageURL!)
        cell.cellOneNotesLabelView.text = data[indexPath.row].userNotes
        cell.cellOneDateLabelView.text = data[indexPath.row].photoDate
        
        
        
        
        return cell
        
        
    }
     let db = Firestore.firestore() //creates instance of the firebase firestone noSQL database.
    //Will have to worry about firebase and timestamps

    /*
     * Function Name: viewDidLoad()
     * When the view controller loads this code is executed.
     * Tucker Mogren; 3/11/19
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        data = [CellData.init(imageURL: "Sam Regalia", userNotes: "I ate a ham sandwich with Mayo, Mustard, and American Cheese on Rye bread with lays salt and vin chips." , photoDate: "03152019"), CellData.init(imageURL: "Sam Regalia", userNotes: "I ate a ham sandwich with Mayo, Mustard, and American Cheese on Rye bread with lays salt and vin chips." , photoDate: "03152019")]
        
        
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
            
            menuButtonOutlet.target = revealViewController()
            menuButtonOutlet.action = #selector(SWRevealViewController.revealToggle(_:))
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

