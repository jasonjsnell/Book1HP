//
//  StoryController.swift
//  Book1HP
//
//  Created by Jason Snell on 6/10/14.
//  Copyright (c) 2014 HKI. All rights reserved.
//

import UIKit

class TextController: UIViewController {
    
    let iowaFont:UIFont = UIFont(name:"IowanOldStyle-Bold", size:34)
    /*
    "IowanOldStyle-Bold",
    "IowanOldStyle-BoldItalic",
    "IowanOldStyle-Italic",
    "IowanOldStyle-Roman"
    */
    
    let colorBrownRed:UIColor = UIColor(red:0.462, green:0.196, blue:0.011, alpha:1.0)
    var currView:UITextView = UITextView()
    var newView:UITextView = UITextView()
    var textTop:CGFloat = 0.0
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
       // * Story controller. Has text, both space and scroll modes.
        
        //create root view
        self.view = UIView(frame: CGRectMake(0, 0, Global.sharedInstance.screenWidth, Global.sharedInstance.screenHeight));
        
        
        //font
        
        
        
        
        //text view
        //textTop = Global.sharedInstance.screenHeight * 0.2
        
        currView.frame = CGRectMake(
            0,
            textTop,
            Global.sharedInstance.screenWidth,
            Global.sharedInstance.screenHeight - textTop)
        
        newView.frame = CGRectMake(
            Global.sharedInstance.screenWidth,
            textTop,
            Global.sharedInstance.screenWidth,
            Global.sharedInstance.screenHeight - textTop)
        
        currView.backgroundColor = UIColor.clearColor()
        newView.backgroundColor = UIColor.clearColor()
        
        currView.editable = false
        newView.editable = false
        
        currView.addObserver(self, forKeyPath: "contentSize", options: .New, context: nil)
        newView.addObserver(self, forKeyPath: "contentSize", options: .New, context: nil)
        
        
        /*
        OLD
        //currView.textColor = UIColor.whiteColor();
        //newView.textColor = UIColor.whiteColor();
        
        //currView.font = iowaFont
        //newView.font = iowaFont
        
        //currView.textAlignment = NSTextAlignment.Center
        //newView.textAlignment = NSTextAlignment.Center
        */
        
        
        var currPageText:String = TextData.sharedInstance.getPageByID(Global.sharedInstance.currPage)
        var formattedPageText = formatText(currPageText)
        currView.attributedText = formattedPageText
        
        newView.attributedText = formattedPageText
        moveTextView(newView, toNewX: Global.sharedInstance.screenWidth)

    
        self.view.addSubview(currView)
        self.view.addSubview(newView)
        
    }
    
    
    
    // anim
    func slideToLeft(){
       
        Global.sharedInstance.currPage++
        var nextPageText:String = TextData.sharedInstance.getPageByID(Global.sharedInstance.currPage)
        
        if (nextPageText == "STORY"){
            println("transition to story, scroll mode")
        } else if (nextPageText == "EPILOG"){
            println("transition to epilog, back to space mode")
        } else if (nextPageText == "END"){
            println("show end screen")
        }
        
        var formattedPageText:NSMutableAttributedString = formatText(nextPageText)
        
        newView.alpha = 0
        newView.attributedText = formattedPageText
        moveTextView(newView, toNewX: Global.sharedInstance.screenWidth)
        
        UIView.animateWithDuration(0.4, delay: 0.0, options:UIViewAnimationOptions.CurveEaseInOut,
            
            animations: {
                
                //move curr off to left side and new text (with new data) to center
                self.moveTextView(self.currView, toNewX:-Global.sharedInstance.screenWidth)
                self.currView.alpha = 0
                
                self.moveTextView(self.newView, toNewX:0)
                self.newView.alpha = 1
                
            }, completion: {(value: Bool) in
                
                //on complete, move text fields back into position and populate curr text with new data
                self.currView.attributedText = formattedPageText
                
                self.moveTextView(self.currView, toNewX:0)
                self.currView.alpha = 1
                
                self.moveTextView(self.newView, toNewX:Global.sharedInstance.screenWidth)
                self.newView.alpha = 0

                
            }
        )

        
    }
    
    func slideToRight(){
        println("slide to right")
    }
    
    //anim
    func moveTextView(view:UITextView, toNewX newX:CGFloat){
        
        println("////")
        println("origin y \(view.frame.origin.y)")
        println(view.contentOffset.y)
        
        view.frame = CGRectMake(
            newX,
            -view.contentOffset.y,
            view.frame.width,
            view.frame.height)
    }
    func moveTextView(view:UIView, toNewY newY:CGFloat){
        view.frame = CGRectMake(
            view.frame.origin.x,
            newY,
            view.frame.width,
            view.frame.height)
    }
    
    
    //formatting
    func formatText(unformattedText:String) -> NSMutableAttributedString {
        var paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Center
        paragraphStyle.minimumLineHeight = 100;
        
        var attrText:NSMutableAttributedString = NSMutableAttributedString(string:unformattedText)
        var attrRange:NSRange = NSMakeRange(0, attrText.length)
        
        attrText.addAttribute(NSKernAttributeName, value: -3.0, range: attrRange)
        attrText.addAttribute(NSFontAttributeName, value: iowaFont, range: attrRange)
        attrText.addAttribute(NSBackgroundColorAttributeName, value: UIColor.clearColor(), range: attrRange)
        attrText.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: attrRange)
        attrText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: attrRange)
        
        return attrText
    }
    
    override func observeValueForKeyPath(keyPath: String!, ofObject object: AnyObject!, change: NSDictionary!, context: CMutableVoidPointer) {
        var textView:UITextView = object as UITextView
        var topCorrect:CGFloat = (textView.bounds.size.height - textView.contentSize.height * textView.zoomScale) / 2.0
        topCorrect = ( topCorrect < 0.0 ? 0.0 : topCorrect)
        textView.contentOffset = CGPointMake(0, -topCorrect)
        
    }

        
}
 