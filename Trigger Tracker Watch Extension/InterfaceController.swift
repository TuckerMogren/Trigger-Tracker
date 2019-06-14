/*
 * Class Name: InterfaceController.swift
 * Description:
 * Developer: Tucker Mogren
 * References: N/A
 * Date: 06/11/2019
 */

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var tableViewWatchOutlet: WKInterfaceTable!
    
    let dates = ["April 25th, 2019 at 10:00 PM, 2019","April 26th, 2019 at 3:45 PM","April 27th, 2019 at 8:45 AM","April 28th, 2019 at 12:15 PM", "April 29th, 2019 at 3:15 PM"];
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        tableView()
    
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    

    private func tableView()
    {
        tableViewWatchOutlet.setNumberOfRows(dates.count, withRowType: "Cell1")
        
        for (index, dataDateFromArray) in dates.enumerated() {
            if let rowController = tableViewWatchOutlet.rowController(at: index) as? dataModel {
                rowController.tableViewLabelOutput.setText(dataDateFromArray)
            }
        }
    }
    
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        pushController(withName: "detailedView", context: dates[rowIndex])
    }
 
}
