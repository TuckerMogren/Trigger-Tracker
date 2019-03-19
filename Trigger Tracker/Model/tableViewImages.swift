/*
 * Class Name: ViewLoggedIn
 * For the welcome screen when you first log into the app.
 * References: https://www.youtube.com/watch?v=rafJcqqyS1E&feature=youtu.be
 * Tucker Mogren; 2/9/19
 */

import Foundation

public class tableViewImages: NSObject {


    var imageName: Array<String> = Array()
    var userNotes: Array<String> = Array()
    var imageDate: Array<String> = Array()
    
    
    
    public override init() {
        
        self.imageName.append("hiEun71BDqfaaLrHWG8FuPTc1u42 Date: 2019-03-18 00:58:34 +0000")
        self.userNotes.append("This is a photo of a red solo cup in front of a computer keyboard.")
        self.imageDate.append("3/17/19 at 8:58:36 PM UTC-4")
        
        
        self.imageName.append("hiEun71BDqfaaLrHWG8FuPTc1u42 Date: 2019-03-18 01:00:48 +0000")
        self.userNotes.append("A wild software developer making a silly face.")
        self.imageDate.append("3/17/19 at 9:00:51 PM UTC-4")
    }
    
}
