//
//  ButtonController.swift
//  Book1HP
//
//  Created by Jason Snell on 6/10/14.
//  Copyright (c) 2014 HKI. All rights reserved.
//

import UIKit

class ButtonController: UIViewController {
    
    var arrowWhiteLeftBtn:UIButton?
    var arrowWhiteRightBtn:UIButton?
    var arrowRedLeftBtn:UIButton?
    var arrowRedRightBtn:UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // * Popup controller. Handles help requests, action confirmations, and image export options.
        
        /*
        * Button Controller. Different configs based on what other controller is being used. Advantages - all buttons are on one layer and accessible, not blocked by other layers. Layering may be tricky as draw gets overlaid on story, and story shows some of its buttons, but not all. And the draw canvas may block the story controller buttons.

        */
        
        //create root view
        self.view = UIView(frame: CGRectMake(0, 0, Global.sharedInstance.screenWidth, Global.sharedInstance.screenHeight));
        
        //arrow buffers
        var arrowHorzBuffer:Float = 48;
        var arrowVertOffset:Float = 0.4;
        
        //white arrows
        let arrowWhiteLeftImg = UIImage(named: "arrow_white_left")
        
        arrowWhiteLeftBtn = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton
        arrowWhiteLeftBtn!.frame = CGRectMake(
            arrowHorzBuffer,
            Global.sharedInstance.screenHeight * arrowVertOffset,
            arrowWhiteLeftImg.size.width,
            arrowWhiteLeftImg.size.height)
        
        arrowWhiteLeftBtn!.setImage(arrowWhiteLeftImg, forState: .Normal)
        
        arrowWhiteLeftBtn!.addTarget(self,
            action: "leftArrowTap:",
            forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(arrowWhiteLeftBtn)
        
        let arrowWhiteRightImg = UIImage(named: "arrow_white_right")
        
        arrowWhiteRightBtn = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton
        arrowWhiteRightBtn!.frame = CGRectMake(
            Global.sharedInstance.screenWidth - arrowHorzBuffer - arrowWhiteRightImg.size.width,
            Global.sharedInstance.screenHeight * arrowVertOffset,
            arrowWhiteRightImg.size.width,
            arrowWhiteRightImg.size.height)
        
        arrowWhiteRightBtn!.setImage(arrowWhiteRightImg, forState: .Normal)
        
        arrowWhiteRightBtn!.addTarget(self,
            action: "rightArrowTap:",
            forControlEvents: UIControlEvents.TouchUpInside)
        
        self.view.addSubview(arrowWhiteRightBtn)
        
        //red arrows
        let arrowRedLeftImg = UIImage(named: "arrow_red_left")
        
        arrowRedLeftBtn = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton
        arrowRedLeftBtn!.frame = CGRectMake(
            arrowHorzBuffer,
            Global.sharedInstance.screenHeight * arrowVertOffset,
            arrowRedLeftImg.size.width,
            arrowRedLeftImg.size.height)
        
        arrowRedLeftBtn!.setImage(arrowRedLeftImg, forState: .Normal)
        
        arrowRedLeftBtn!.addTarget(self,
            action: "leftArrowTap:",
            forControlEvents: UIControlEvents.TouchUpInside)
        
        arrowRedLeftBtn!.hidden = true;
        self.view.addSubview(arrowRedLeftBtn)
        
        let arrowRedRightImg = UIImage(named: "arrow_red_right")
        
        arrowRedRightBtn = UIButton.buttonWithType(UIButtonType.Custom) as? UIButton
        arrowRedRightBtn!.frame = CGRectMake(
            Global.sharedInstance.screenWidth - arrowHorzBuffer - arrowRedRightImg.size.width,
            Global.sharedInstance.screenHeight * arrowVertOffset,
            arrowRedRightImg.size.width,
            arrowRedRightImg.size.height)
        
        arrowRedRightBtn!.setImage(arrowRedRightImg, forState: .Normal)
        
        arrowRedRightBtn!.addTarget(self,
            action: "rightArrowTap:",
            forControlEvents: UIControlEvents.TouchUpInside)
        
        arrowRedRightBtn!.hidden = true;
        self.view.addSubview(arrowRedRightBtn)

        
    }
    
    //taps
    func leftArrowTap(sender: UIButton!) {
        println("left tapped button")
    }
    
    func rightArrowTap(sender: UIImageView!) {
        println("right tapped button")
    }

    
    
    
}