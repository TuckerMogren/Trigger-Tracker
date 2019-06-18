//
//  tableViewDetailedView.swift
//  Trigger Tracker Watch Extension
//
//  Created by Tucker Mogren on 6/13/19.
//  Copyright © 2019 TuckerMogren. All rights reserved.
//

import WatchKit

class tableViewDetailedView: WKInterfaceController {
    
    @IBOutlet weak var tableDetailedViewOutlet: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
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
