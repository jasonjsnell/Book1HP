//
//  ToolController.swift
//  Book1HP
//
//  Created by Jason Snell on 6/10/14.
//  Copyright (c) 2014 HKI. All rights reserved.
//

import UIKit

class ToolController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // * Tool controller. Handles tool kit for draw screen. Select and highlight tools, colors, or eraser.
        
        //create root view
        self.view = UIView(frame: CGRectMake(0, 0, Global.sharedInstance.screenWidth, Global.sharedInstance.screenHeight));
        
    }
}
