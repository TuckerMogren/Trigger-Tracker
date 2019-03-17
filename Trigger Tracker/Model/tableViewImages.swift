/*
 * Class Name: ViewLoggedIn
 * For the welcome screen when you first log into the app.
 * References: https://www.youtube.com/watch?v=rafJcqqyS1E&feature=youtu.be
 * Tucker Mogren; 2/9/19
 */

import Foundation

public class tableViewImages {

    var key: String
    var imageName: String
    var userNotes: String
    var photoDate: NSDate
    
    init(dictionary: [String: AnyObject], key: String) {
        self.key = key
        self.imageName = dictionary["imageName"] as! String
        self.userNotes = dictionary["notes"] as! String
        self.photoDate = dictionary["date"] as! NSDate
        
    }
        
    

}
