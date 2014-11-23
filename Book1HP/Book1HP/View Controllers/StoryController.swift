//
//  StoryController.swift
//  Book1HP
//
//  Created by Jason Snell on 6/10/14.
//  Copyright (c) 2014 HKI. All rights reserved.
//

import UIKit

class StoryController: UIViewController, NSLayoutManagerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
       // * Story controller. Has text, next/prev. Has both space and scroll modes.
        
        //create root view
        self.view = UIView(frame: CGRectMake(0, 0, Global.sharedInstance.screenWidth, Global.sharedInstance.screenHeight));
        
        
        //font
        let iowaFont:UIFont = UIFont(name:"IowanOldStyle-Bold", size:36)
        /*
        "IowanOldStyle-Bold",
        "IowanOldStyle-BoldItalic",
        "IowanOldStyle-Italic",
        "IowanOldStyle-Roman"
        */
        
        
        //text view
        let textTop:Float = Global.sharedInstance.screenHeight * 0.2
        
        let textView:UITextView = UITextView(frame: CGRectMake(
            0,
            textTop,
            Global.sharedInstance.screenWidth,
            Global.sharedInstance.screenHeight - textTop)
        )

        
        textView.text = "Ageyya descended from the Heavens above.\nAgeyya was made of kindness and love.\nShe came here to show us just how to care,\nBy guiding us all in a new way — to share."
        //field.text = [[TextData sharedTextData] getPrologPassageBy:0];
        textView.backgroundColor = UIColor.clearColor()
        textView.textColor = UIColor.whiteColor();
        textView.font = iowaFont;
        textView.textAlignment = NSTextAlignment.Center;
        textView.editable = false;
        textView.layoutManager.delegate = self;
        
        self.view.addSubview(textView)
        
        
        
                
    }
    
    //sets leading / line spacing
    func layoutManager(
        layoutManager: NSLayoutManager!,
        lineSpacingAfterGlyphAtIndex
        glyphIndex: Int,
        withProposedLineFragmentRect rect: CGRect) -> CGFloat {
            
            return Global.sharedInstance.screenHeight * 0.05
    }
    
}
 