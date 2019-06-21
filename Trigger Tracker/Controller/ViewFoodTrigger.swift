/*
 * Class Name: ViewFoodTrigger
 * For the welcome screen when you first log into the app.
 * References: https://www.youtube.com/watch?v=rafJcqqyS1E&feature=youtu.be
 * Tucker Mogren; 2/9/19
 */
import UIKit
import Foundation
class ViewFoodTrigger: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextViewDelegate {
    
    @IBOutlet weak var imageViewUpload: UIImageView!
    //menuButton: Allows the user to be brought back to the slidebar for navigation.
    @IBOutlet weak var menuButton: UIBarButtonItem!
    var imagePickerController: UIImagePickerController!
    @IBOutlet weak var uploadPhotoButton: CustomShapeButton!
    @IBOutlet weak var userTextTextFieldOutlet: UITextView!
    
    
    
    
    let userAuth = (UIApplication.shared.delegate as! AppDelegate).fireBaseAuth
    let fireBaseDocumentRef = (UIApplication.shared.delegate as! AppDelegate).fireBaseNoSQLDBDocumentRef
    let db = (UIApplication.shared.delegate as! AppDelegate).fireBaseNoSQLDB
    //Created a image reference in firebase storage for the image with path.
    let imageReference = (UIApplication.shared.delegate as! AppDelegate).fireBaseStorage?.reference().child("images")
    

    /*
     * Function Name: viewDidLoad()
     * When the view controller loads this code is executed.
     * Tucker Mogren; 2/9/19
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenus()
        customizeNavBar()
        self.uploadPhotoButton.isHidden = true
        
        userTextTextFieldOutlet.delegate = self
        
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
     * Function Name: textFieldShouldReturn()
     * Will allow the keyboard to be toggled away when the text view is done being editted
     * Tucker Mogren; 4/15/19
     * Reference: https://stackoverflow.com/questions/26600359/dismiss-keyboard-with-a-uitextview
     */
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n")
        {
            userTextTextFieldOutlet.resignFirstResponder()
            return false
        }
        return true
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
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1960784314, green: 0.3215686275, blue: 1, alpha: 1)
        
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
            self.uploadPhotoButton.isHidden = false 
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
        guard let imageData = image.jpegData(compressionQuality: 0.10) else {return}
        
        
        let fileName = "\((userAuth?.currentUser?.uid)!)" + " Date: " + "\(NSDate())"
        
        let uploadImageRef = imageReference?.child((userAuth?.currentUser!.uid)!).child(fileName) // will need to add comments to explain whats going on here
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        //gets the date interval from the current time
        let date = Date(timeIntervalSinceNow: 0.0)
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
                      
                            self.sendDataToDatabase(userNotes: self.userTextTextFieldOutlet.text, imageName: fileName, imageDate: dateFormatter.string(from: date))
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
    private func sendDataToDatabase (userNotes: String, imageName: String, imageDate: String ){
        
        
        var ref = fireBaseDocumentRef
    


        ref = db?.collection("photoInformation").addDocument(data: [
            
            
            "userID" : userAuth?.currentUser?.uid as Any,
            "userNotes": userNotes,
            "imageName": imageName,
            "imageDate": imageDate
            
            
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
