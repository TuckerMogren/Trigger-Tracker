/*
 * Name: ViewPhotoGallery
 * Description: Code for photo gallery.
 * Author/Date: Tucker J. Mogren 3/11/19
 * References:
 */
import UIKit

class ViewPhotoGallery: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    let userAuth = (UIApplication.shared.delegate as! AppDelegate).fireBaseAuth
    let db = (UIApplication.shared.delegate as! AppDelegate).fireBaseNoSQLDB

    @IBOutlet weak var tableViewOutlet: UITableView!
    
    var arrayOfData = [tableViewImages]()
    @IBOutlet weak var menuButtonOutlet: UIBarButtonItem!
    
    //Ambigious reference error fixed with reference to: https://stackoverflow.com/questions/33724190/ambiguous-reference-to-member-tableview
    
    
    /*
     * Function Name: viewDidLoad()
     * When the view controller loads this code is executed.
     * Tucker Mogren; 3/11/19
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        customizeNavBar()
        loadData()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfData.count;
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOne", for: indexPath) as! CustomTableViewCell
        
        cell.cellOneDateLabelView.text = arrayOfData[indexPath.row].photoDate
        cell.cellOneNotesLabelView.text = arrayOfData[indexPath.row].userNotes
        
        let imageRef = (UIApplication.shared.delegate as! AppDelegate).fireBaseStorage?.reference().child("images").child((userAuth?.currentUser!.uid)!).child(arrayOfData[indexPath.row].photoURL)
        
        imageRef?.getData(maxSize: 1024 * 1024 * 1024, completion: { (data, err) in
            if let err = err {
                print("ERROR: \(err).")
            }else {
                cell.cellOneImageView.image = UIImage(data: data!)
            }
        })
        return cell

    }
    
    /*
     * Function: loadData()
     * Loads data from storage and database to be displayed to user
     * Reference:
     * Tucker Mogren; March/April 2019
     */
   private func loadData()
    {
        
        db?.collection("photoInformation").whereField("userID", isEqualTo: userAuth?.currentUser?.uid as Any).getDocuments(completion: { (snapshot, err) in
            if let err = err {
                print(err.localizedDescription)
            }else{
                if let snapshot = snapshot {
                    for document in snapshot.documents{
                        
                        let data = document.data()
                        let dataImageName = data["imageName"] as? String ?? ""
                        let dataImageDate = data["imageDate"] as? String ?? ""
                        let dataUserNotes = data["userNotes"] as? String ?? ""
                        
                        let newData = tableViewImages(URL: dataImageName, Notes: dataUserNotes, Date: dataImageDate)
                        
                        self.arrayOfData.append(newData)
                        
                        
                    }
                    self.tableViewOutlet.reloadData()
                }
            }
        })


    }
    
    
    /*
     * Function Name: sideMenus()
     * Shows the side bar controller.
     * Tucker Mogren; 2/9/19
     */
   private func sideMenus() {
        
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

