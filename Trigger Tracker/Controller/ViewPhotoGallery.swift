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
    @IBOutlet weak var menuButtonOutlet: UIBarButtonItem!
    var arrayOfData = [tableViewImages]()
    
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
       
        cell.cellOneImageView.isHidden = true
        cell.cellOneProgressView.isHidden = false
        
        cell.cellOneDateLabelView.text = self.arrayOfData[indexPath.row].photoDate
        cell.cellOneNotesLabelView.text = self.arrayOfData[indexPath.row].userNotes
        

        
        let storageRef = (UIApplication.shared.delegate as! AppDelegate).fireBaseStorage?.reference()
        let imageRef = storageRef!.child("images").child((userAuth?.currentUser!.uid)!).child(arrayOfData[indexPath.row].photoURL)
        let imageDownloadAndDisplay = imageRef.getData(maxSize: 1 * 1024 * 1024, completion: { (data, err) in
            if let err = err {
                print("ERROR: \(err).")
            }else {
                cell.cellOneImageView.isHidden = false
                cell.cellOneProgressView.isHidden = true
                cell.cellOneImageView.image = UIImage(data: data!)
                
                
            }
        })

        imageDownloadAndDisplay.observe(.progress) { (snapshot) in
            let currentProgress = (100.00 * Float(snapshot.progress!.completedUnitCount) / Float(snapshot.progress!.totalUnitCount))
            cell.cellOneProgressView.setProgress(currentProgress, animated: true)
        }
        return cell

    }
    
    /*
     * Function: loadData()
     * Loads data from storage and database to be displayed to user
     * Reference:
     * Tucker Mogren; March/April 2019
     */
   public func loadData()
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
                    //self.tableViewOutlet.reloadData() moved from here to current location to fix a bug with loading photos being covered by a previous cell photo
                }
                //test to see if it makes any different.
                DispatchQueue.main.async(execute: {
                    self.tableViewOutlet.reloadData()
                })

                //self.tableViewOutlet.reloadData()
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

