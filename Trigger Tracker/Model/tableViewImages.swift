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
        self.imageName.append("")
        self.userNotes.append("")
        self.imageDate.append("")
        
    }
    
}
