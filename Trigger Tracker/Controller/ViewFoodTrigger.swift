/*
 * Class Name: ViewFoodTrigger
 * For the welcome screen when you first log into the app.
 * References: https://www.youtube.com/watch?v=rafJcqqyS1E&feature=youtu.be
 * Tucker Mogren; 2/9/19
 */
import UIKit


class ViewFoodTrigger: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var imagePickerController: UIImagePickerController!
    
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
     * Function Name: showAlertCameraWillNotOpenSimulator()
     * Wil throw alert if the camera can not open because testing on xcode simulator. Will avoid crash.
     * Tucker Mogren; 2/12/19
     * Referenced: https://stackoverflow.com/questions/24022479/how-would-i-create-a-uialertview-in-swift/33340757#33340757
     */
    func showAlertCameraWillNotOpenSimulator()
    {
        let alert = UIAlertController(title: "Error: Using Simulator", message: "Camera will not open in the xcode simulator.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
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
     * Function: takePhotoActionButton()
     * Will use PhotoKit to take a photo and display it in imageView
     * Reference: https://appsandbiscuits.com/take-save-and-retrieve-a-photo-ios-13-4312f96793ff
     * Tucker Mogren; 2/10/19
     */
    @IBAction func takePhotoActionButton(_ sender: Any)
    {
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self;
        
        if(!UIImagePickerController.isSourceTypeAvailable(.camera))
        {
            showAlertCameraWillNotOpenSimulator()
            
        }else{
            imagePickerController.sourceType = .camera
            
            
        }

        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    /*
     * Function: imagePickerController()
     * Executes after the photo is taken
     * Reference: https://appsandbiscuits.com/take-save-and-retrieve-a-photo-ios-13-4312f96793ff
     * Tucker Mogren; 2/10/19
     */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePickerController.dismiss(animated: true, completion: nil)
        imageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
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
