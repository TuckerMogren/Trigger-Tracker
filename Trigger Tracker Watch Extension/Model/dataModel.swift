
import Foundation
import WatchKit

class dataModel: NSObject {
    
    //first table row element selector
    @IBOutlet weak var tableViewLabelOutput: WKInterfaceLabel!
    
    
    //Everything below is currently unused
    var photoDate : String
    init(Date: String) {
            photoDate = Date
    }
    
}
