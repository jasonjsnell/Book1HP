//
//  DrawController.swift
//  Book1HP
//
//  Created by Jason Snell on 6/10/14.
//  Copyright (c) 2014 HKI. All rights reserved.
//

import UIKit

class DrawingController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //http://www.raywenderlich.com/18840/how-to-make-a-simple-drawing-app-with-uikit
        
        // * Draw controller. Has both space and scroll modes (different graphics). Has tools, canvas, undo, start over, save, print, and back buttons.
        
        //create root view
        self.view = UIView(frame: CGRectMake(0, 0, Global.sharedInstance.screenWidth, Global.sharedInstance.screenHeight));
        
    }
}
