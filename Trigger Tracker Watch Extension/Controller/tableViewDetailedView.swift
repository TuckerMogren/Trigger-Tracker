//
//  tableViewDetailedView.swift
//  Trigger Tracker Watch Extension
//
//  Created by Tucker Mogren on 6/13/19.
//  Copyright © 2019 TuckerMogren. All rights reserved.
//

import WatchKit

class tableViewDetailedView: WKInterfaceController {
    //IBoutlet for the detailed table (table that you come to when you click on a row)
    @IBOutlet weak var tableDetailedViewOutlet: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        // will loop through the data array and set each row equal to an element in the array to be displayed on the watchface. Appears in the detailed table the detailed table (table that you come to when you click on a row)
        if let data = context as? String {
            tableDetailedViewOutlet.setText(data)
        }
    }
    
    override func willActivate() {
        super.willActivate()
    }
    
    override func didDeactivate() {
        super.didDeactivate()
    }
    
}
