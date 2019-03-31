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
        
    
        //these will happen in the db completion block in the tableView(cellForRowAt)
        self.imageName.append("hiEun71BDqfaaLrHWG8FuPTc1u42 Date: 2019-03-30 20:41:06 +0000")
        self.userNotes.append("Test 3")
        self.imageDate.append("Test 2")
        
    }
    
}
