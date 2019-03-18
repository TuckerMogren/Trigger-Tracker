/*
 * Name: ViewPhotoGallery
 * Description: Code for photo gallery.
 * Author/Date: Tucker J. Mogren 3/11/19
 * References:
 */
import UIKit

class ViewPhotoGallery: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var imageData : [tableViewImages] = [tableViewImages]()
    @IBOutlet weak var menuButtonOutlet: UIBarButtonItem!

    //Ambigious reference error fixed with reference to: https://stackoverflow.com/questions/33724190/ambiguous-reference-to-member-tableview
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageData.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellOne", for: indexPath) as! CustomTableViewCell
        
        cell.cellOneDateLabelView.text = imageData[indexPath.row].photoDate.description
        cell.cellOneNotesLabelView.text = imageData[indexPath.row].userNotes
        
        if (imageData[indexPath.row].imageName.count > 0) {
            let imageRef = (UIApplication.shared.delegate as! AppDelegate).fireBaseStorage?.reference().child("images").child(imageData[indexPath.row].imageName)
            imageRef?.getData(maxSize: 1024 * 1024 * 10, completion: { (data, err) in
                if err != nil {
                    //do something if its not nil
                }else{
                    //do something if its nil
                }
            })
        }
        
        return cell

    }
    
    //Will have to worry about firebase and timestamps

    /*
     * Function Name: viewDidLoad()
     * When the view controller loads this code is executed.
     * Tucker Mogren; 3/11/19
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        imageData = [tableViewImages]()
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

