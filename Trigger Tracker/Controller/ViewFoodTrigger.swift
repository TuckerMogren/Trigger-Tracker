/*
 * Class Name: ViewFoodTrigger
 * For the welcome screen when you first log into the app.
 * References: https://www.youtube.com/watch?v=rafJcqqyS1E&feature=youtu.be
 * Tucker Mogren; 2/9/19
 */
import UIKit
import Foundation
class ViewFoodTrigger: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var imageViewUpload: UIImageView!
    //menuButton: Allows the user to be brought back to the slidebar for navigation.
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var imagePickerController: UIImagePickerController!
    @IBOutlet weak var uploadPhotoButton: CustomShapeButtonLogFood!
    
    let userAuth = (UIApplication.shared.delegate as! AppDelegate).fireBaseAuth
    let fireBaseDocumentRef = (UIApplication.shared.delegate as! AppDelegate).fireBaseNoSQLDBDocumentRef
    let db = (UIApplication.shared.delegate as! AppDelegate).fireBaseNoSQLDB
    let imageReference = (UIApplication.shared.delegate as! AppDelegate).fireBaseStorage?.reference().child("images")
    //Created a image reference in firebase storage for the image with path.
    /* Commeted out becuase trying a new method that uses data from the appDelegate file
    var imageReference:  {
        return Storage.storage().reference().child("images")
    }
    */
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
        imageViewUpload.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
    }
    
    /*
     * Function Name: uploadPhotoButtonAction()
     * Will upload the photo to Firebases Storage Server
     * Tucker Mogren; 2/24/19
     * Referenced: https://www.youtube.com/watch?v=MyeqhFGnJ_0
     */
    @IBAction func uploadPhotoButtonAction(_ sender: Any)
    {
        
        guard let image = imageViewUpload.image else {return }
        guard let imageData = image.jpegData(compressionQuality: 0.25) else {return}
        
        
        let fileName = "\((userAuth?.currentUser?.uid)!)" + " Date: " + "\(NSDate())"
        
        let uploadImageRef = imageReference?.child(fileName)
        

        
        let imageUpdate = uploadImageRef?.putData(imageData, metadata: nil, completion:
        
            { (metadata, err)   in
            
            if err != nil {
                print("ERROR: \(String(describing: err))")
                return
            }
                uploadImageRef?.downloadURL(completion: { (url, err) in
                        if err != nil{
                            print("ERROR: \(String(describing: err))")
                        }else{
                            print(url?.absoluteString as Any)
                            
                    self.sendDataToDatabase(email: (self.userAuth?.currentUser?.email)!, fileName: fileName
                        , downloadURL: url?.absoluteString as Any as! String, imageDate: NSDate()) //CVTimestamp vs Timestamp?
                }
            })
            
        })
        
        imageUpdate?.observe(.progress) { (snapshot) in
            print(snapshot.progress ?? "Done uploading image.")
        }

        imageUpdate?.resume()
        
    }
    /*
     * Function Name: sendDataToDatabase
     * Function will send specific static data to the database when called.
     * Tucker Mogren; 3/13/19
     * Reference: https://firebase.google.com/docs/firestore/quickstart
     */
    private func sendDataToDatabase (email: String, fileName: String, downloadURL: String, imageDate: NSDate ){
        
        
        var ref = fireBaseDocumentRef
    


        ref = db?.collection("photoInformation").addDocument(data: [
            
            
            "eMail":email,
            "user_ID": userAuth?.currentUser?.uid as Any,
            "imageFileName": fileName,
            "imageDownloadID": downloadURL,
            "imageTimeStamp": imageDate
            
            
        ]){ err in
            if let err = err {
                print("Error adding document: \(err)")
            }else {
                print("Document added with ID: \(ref!.documentID)")
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
