//
//  PopupController.swift
//  Book1HP
//
//  Created by Jason Snell on 6/10/14.
//  Copyright (c) 2014 HKI. All rights reserved.
//

import UIKit

class PopupController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // * Popup controller. Handles help requests, action confirmations, and image export options.
        
        //create root view
        self.view = UIView(frame: CGRectMake(0, 0, Global.sharedInstance.screenWidth, Global.sharedInstance.screenHeight));
        
    }
}