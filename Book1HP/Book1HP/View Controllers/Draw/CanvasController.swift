//
//  CanvasController.swift
//  Book1HP
//
//  Created by Jason Snell on 6/10/14.
//  Copyright (c) 2014 HKI. All rights reserved.
//

import UIKit

class CanvasController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // * Canvas controller. Handles touch inputs and draws on layers with stroke and color set by tool controller. Undo button undoes the last movement. Start over clears the canvas. Print and save contact the export controller.
        
        //create root view
        self.view = UIView(frame: CGRectMake(0, 0, Global.sharedInstance.screenWidth, Global.sharedInstance.screenHeight));
        
    }
}

