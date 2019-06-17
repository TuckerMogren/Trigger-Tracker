
import Foundation
import WatchKit

class dataModel: NSObject {
    
    @IBOutlet weak var tableViewLabelOutput: WKInterfaceLabel!
    var photoDate : String
        
    init(Date: String) {
            photoDate = Date
    }
    
}
