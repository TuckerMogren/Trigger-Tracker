/*
 * Name: ViewPhotoGallery
 * Description: Code for photo gallery.
 * Author/Date: Tucker J. Mogren 3/11/19
 * References:
 */
import UIKit

class ViewPhotoGallery: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var imageData = tableViewImages()
    @IBOutlet weak var menuButtonOutlet: UIBarButtonItem!

    //Ambigious reference error fixed with reference to: https://stackoverflow.com/questions/33724190/ambiguous-reference-to-member-tableview
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ((imageData.imageName.count))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOne", for: indexPath) as! CustomTableViewCell
        //subtracting indexPath.row - 1 in order to ignore the init blanks in tableViewImages
        cell.cellOneDateLabelView.text = imageData.imageDate[indexPath.row]
        cell.cellOneNotesLabelView.text = imageData.userNotes[indexPath.row]
        
        
        //have all this code in the completion block in the read database method????
        let imageRef = (UIApplication.shared.delegate as! AppDelegate).fireBaseStorage?.reference().child("images").child(imageData.imageName[indexPath.row])
        imageRef?.getData(maxSize: 1024 * 1024 * 10, completion: { (data, err) in
            if let err = err{
                print("ERROR: \(err)")
                
            }else{
                cell.cellOneImageView.image = UIImage(data: data!)
            }
        })
        return cell

    }
    
    /*
     * Function Name: viewDidLoad()
     * When the view controller loads this code is executed.
     * Tucker Mogren; 3/11/19
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        customizeNavBar()
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

