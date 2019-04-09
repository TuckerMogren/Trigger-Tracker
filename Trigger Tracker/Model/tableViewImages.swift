/*
 * Class Name: tableViewImages
 * Data Model to hold data from the database.
 * References: https://www.youtube.com/watch?v=Aw5Hb_A_eFI
 * Tucker Mogren; 4/8/19
 */

import Foundation

class tableViewImages {
    
    var photoURL : String
    var userNotes : String
    var photoDate : String
    
    init(URL: String, Notes: String, Date: String) {
        photoURL = URL
        userNotes = Notes
        photoDate = Date
    }

    
}
