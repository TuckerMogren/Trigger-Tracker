//
//  SideViewController.swift
//  Trigger Tracker
//
//  Created by Tucker Mogren on 2/4/19.
//  Copyright © 2019 TuckerMogren. All rights reserved.
//

import UIKit

protocol SideBarMenuDelegate {
    func sideBarMenuSelected(_ index: Int32)
}

class SideViewController: UIViewController {

    var buttonMenu: UIButton!
    var delegate: SideBarMenuDelegate?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
