//
//  StoryController.swift
//  Book1HP
//
//  Created by Jason Snell on 6/10/14.
//  Copyright (c) 2014 HKI. All rights reserved.
//

import UIKit

class TextController: UIViewController {
    
    var parentView:UIView = UIView()
    
    let iowaFont34:UIFont = UIFont(name:"IowanOldStyle-Bold", size:34)!
    let iowaFont26:UIFont = UIFont(name:"IowanOldStyle-Bold", size:26)!
    /*
    "IowanOldStyle-Bold",
    "IowanOldStyle-BoldItalic",
    "IowanOldStyle-Italic",
    "IowanOldStyle-Roman"
    */
    
    let colorBrownRed:UIColor = UIColor(red:0.462, green:0.196, blue:0.011, alpha:1.0)
    
    var formattedPageText:NSMutableAttributedString = NSMutableAttributedString()
    
    var currView:UITextView = UITextView()
    var newView:UITextView = UITextView()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        //create root view
        self.view = UIView(frame: CGRectMake(0, 0, Global.sharedInstance.screenWidth, Global.sharedInstance.screenHeight));
        
        //no taps register on this view
        self.view.userInteractionEnabled = false
        
        //text views
        currView.frame = CGRectMake(
            0,
            0,
            Global.sharedInstance.screenWidth,
            Global.sharedInstance.screenHeight)
        
        //set off frame to right
        newView.frame = CGRectMake(
            Global.sharedInstance.screenWidth,
            0,
            Global.sharedInstance.screenWidth,
            Global.sharedInstance.screenHeight)
        
        //clear background - this doesn't seem to work just through the NSAttributeString formatting
        currView.backgroundColor = UIColor.clearColor()
        newView.backgroundColor = UIColor.clearColor()
        
        //code that runs each time text data is changed in text field
        currView.addObserver(self, forKeyPath: "contentSize", options: .New, context: nil)
        newView.addObserver(self, forKeyPath: "contentSize", options: .New, context: nil)
        
        //hide
        currView.alpha = 0
        newView.alpha = 0
        moveTextView(currView, toNewX: Global.sharedInstance.screenWidth)
        moveTextView(newView, toNewX: Global.sharedInstance.screenWidth)
        
        //add views
        self.view.addSubview(currView)
        self.view.addSubview(newView)
        
    }
    
    //MARK: state changes
    
    func showHonorPledge(){
        
        Global.sharedInstance.currPage = TextData.sharedInstance.pages.count-1
        var nextPageText:String = TextData.sharedInstance.getPageByID(Global.sharedInstance.currPage)
        
        formattedPageText = formatPledgeText(nextPageText)
        
        //hide and move left, offscreen
        newView.alpha = 0
        moveTextView(newView, toNewX: Global.sharedInstance.screenWidth)
        
        //hide curr too
        currView.alpha = 0
        moveTextView(currView, toNewX: 0)
        currView.attributedText = formattedPageText
        
        //slight delay to give a split second for text to set before animating it
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.1,
            target: self,
            selector: Selector("showHonorPledgeExe"),
            userInfo: nil,
            repeats: false)

    }
    
    func showHonorPledgeExe(){
        
        UIView.animateWithDuration(0.4, delay: 0.0, options:UIViewAnimationOptions.CurveEaseInOut,
            
            animations: {
                
                self.currView.alpha = 1
                
            }, completion: {(value: Bool) in
                
            }
        )
        
    }

    
    func hideHonorPledge(){
        
        UIView.animateWithDuration(0.4, delay: 0.0, options:UIViewAnimationOptions.CurveEaseInOut,
            
            animations: {
                
                self.currView.alpha = 0
                
            }, completion: {(value: Bool) in
                
                self.currView.alpha = 0
                self.newView.alpha = 0
                self.moveTextView(self.currView, toNewX: Global.sharedInstance.screenWidth)
                self.moveTextView(self.newView, toNewX: Global.sharedInstance.screenWidth)
            }
        )
    }

    
    
    
    // MARK: anim
    //slides
    func slideToLeft(){
       
        Global.sharedInstance.currPage++
        var nextPageText:String = TextData.sharedInstance.getPageByID(Global.sharedInstance.currPage)
        
        formattedPageText = formatStoryText(nextPageText)
        
        //hide and move left, offscreen
        newView.alpha = 0
        newView.attributedText = formattedPageText
        
        //slight delay to give a split second for text to set before animating it
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.1,
            target: self,
            selector: Selector("slideToLeftExe"),
            userInfo: nil,
            repeats: false)
        
    }
    
    func slideToLeftExe(){
        
        //move new text field to left side and center it vertically
        moveTextView(newView, toNewX: Global.sharedInstance.screenWidth)
        
        UIView.animateWithDuration(0.4, delay: 0.0, options:UIViewAnimationOptions.CurveEaseInOut,
            
            animations: {
                
                //move and hide curr off to left side
                self.moveTextView(self.currView, toNewX:-Global.sharedInstance.screenWidth)
                self.currView.alpha = 0
                
                //move in and show next text, coming in from right side
                self.moveTextView(self.newView, toNewX:0)
                self.newView.alpha = 1
                
            }, completion: {(value: Bool) in
                
                self.slideComplete()
            
            }
        )

    }

    func slideToRight(){
        
        Global.sharedInstance.currPage--
        var nextPageText:String = TextData.sharedInstance.getPageByID(Global.sharedInstance.currPage)
        
        formattedPageText = formatStoryText(nextPageText)
        
        //hide and move left, offscreen
        newView.alpha = 0
        newView.attributedText = formattedPageText
        
        //slight delay to give a split second for text to set before animating it
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.1,
            target: self,
            selector: Selector("slideToRightExe"),
            userInfo: nil,
            repeats: false)
        
    }
    
    func slideToRightExe(){
        
        //move new text field to side and center it vertically
        moveTextView(newView, toNewX: -Global.sharedInstance.screenWidth)
        
        UIView.animateWithDuration(0.4, delay: 0.0, options:UIViewAnimationOptions.CurveEaseInOut,
            
            animations: {
                
                //move and hide curr off to right side
                self.moveTextView(self.currView, toNewX:Global.sharedInstance.screenWidth)
                self.currView.alpha = 0
                
                //move in and show next text, coming in from right side
                self.moveTextView(self.newView, toNewX:0)
                self.newView.alpha = 1
                
            }, completion: {(value: Bool) in
                
                self.slideComplete()
                
            }
        )
        
    }


    func slideComplete(){
        
        //popupate curr with new text
        self.currView.attributedText = self.formattedPageText
        
        //hide the next text field off screen
        moveTextView(newView, toNewX:Global.sharedInstance.screenWidth)
        newView.alpha = 0
        
        //move curr back to center screen and center vertically
        moveTextView(currView, toNewX:0)
        currView.alpha = 1
        
         NSNotificationCenter.defaultCenter().postNotificationName("swipeTextComplete", object: self)
        
    }
    
    //slide in from right without having a current field in the center sliding out to the left
    func enterFromRight(){
        
        var nextPageText:String = TextData.sharedInstance.getPageByID(Global.sharedInstance.currPage)
        
        formattedPageText = formatStoryText(nextPageText)
        
        //hide and move left, offscreen
        newView.alpha = 0
        moveTextView(newView, toNewX: Global.sharedInstance.screenWidth)
        
        //hide curr too
        currView.alpha = 0
        moveTextView(currView, toNewX: Global.sharedInstance.screenWidth)
        currView.attributedText = formattedPageText
        
        //slight delay to give a split second for text to set before animating it
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.1,
            target: self,
            selector: Selector("enterFromRightExe"),
            userInfo: nil,
            repeats: false)
        
    }
    
    func enterFromRightExe(){
        
        UIView.animateWithDuration(0.4, delay: 0.0, options:UIViewAnimationOptions.CurveEaseInOut,
            
            animations: {
                
                //move in and show next text, coming in from right side
                self.moveTextView(self.currView, toNewX:0)
                self.currView.alpha = 1
                
            }, completion: {(value: Bool) in
                
                self.slideComplete()
                
            }
        )
        
    }

    //slide in from right without having a current field in the center sliding out to the left
    func fadeInCenter(){
        
        var nextPageText:String = TextData.sharedInstance.getPageByID(Global.sharedInstance.currPage)
        
        formattedPageText = formatStoryText(nextPageText)
        
        //hide and move left, offscreen
        newView.alpha = 0
        moveTextView(newView, toNewX: Global.sharedInstance.screenWidth)
        
        //hide curr too
        currView.alpha = 0
        moveTextView(currView, toNewX: 0)
        currView.attributedText = formattedPageText
        
        //slight delay to give a split second for text to set before animating it
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.1,
            target: self,
            selector: Selector("fadeInCenterExe"),
            userInfo: nil,
            repeats: false)
        
    }
    
    func fadeInCenterExe(){
        
        UIView.animateWithDuration(0.4, delay: 0.0, options:UIViewAnimationOptions.CurveEaseInOut,
            
            animations: {
               
                self.currView.alpha = 1
                
            }, completion: {(value: Bool) in
                
                self.slideComplete()
                
            }
        )
        
    }

    
    //exit to left without having a new field come in from the right
    func exitToLeft(){
        
        UIView.animateWithDuration(0.4, delay: 0.0, options:UIViewAnimationOptions.CurveEaseInOut,
            
            animations: {
                
                //move in and show next text, coming in from right side
                self.moveTextView(self.currView, toNewX:-Global.sharedInstance.screenWidth)
                self.currView.alpha = 1
                
            }, completion: {(value: Bool) in

            }
        )
        
    }

    
    //MARK: move text
    func moveTextView(view:UITextView, toNewX newX:CGFloat){
        
        view.frame = CGRectMake(
            newX,
            view.frame.origin.y,
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
    
    
    //MARK: formatting
    func formatStoryText(unformattedText:String) -> NSMutableAttributedString {
        var paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Center
        paragraphStyle.minimumLineHeight = 70;
        
        var attrText:NSMutableAttributedString = NSMutableAttributedString(string:unformattedText)
        var attrRange:NSRange = NSMakeRange(0, attrText.length)
        
        attrText.addAttribute(NSKernAttributeName, value: -1.8, range: attrRange)
        attrText.addAttribute(NSFontAttributeName, value: iowaFont34, range: attrRange)
        attrText.addAttribute(NSBackgroundColorAttributeName, value: UIColor.clearColor(), range: attrRange)
        attrText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: attrRange)
        
        if (Global.sharedInstance.bg == Global.sharedInstance.SPACE){
            attrText.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: attrRange)
        } else {
            attrText.addAttribute(NSForegroundColorAttributeName, value: colorBrownRed, range: attrRange)
        }
        
        return attrText
    }
    
    func formatPledgeText(unformattedText:String) -> NSMutableAttributedString {
        var paragraphStyle:NSMutableParagraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = NSTextAlignment.Center
        paragraphStyle.minimumLineHeight = 70;
        
        var attrText:NSMutableAttributedString = NSMutableAttributedString(string:unformattedText)
        var attrRange:NSRange = NSMakeRange(0, attrText.length)
        
        attrText.addAttribute(NSKernAttributeName, value: -0.7, range: attrRange)
        attrText.addAttribute(NSFontAttributeName, value: iowaFont26, range: attrRange)
        attrText.addAttribute(NSBackgroundColorAttributeName, value: UIColor.clearColor(), range: attrRange)
        attrText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: attrRange)
        attrText.addAttribute(NSForegroundColorAttributeName, value: UIColor.whiteColor(), range: attrRange)
        
        return attrText
    }
    
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        var textView:UITextView = object as UITextView
        moveTextView(textView, toNewY: getVerticalCenterForTextView(textView))
    }
    /*
    override func observeValueForKeyPath(keyPath: String!, ofObject object: AnyObject!, change: [NSObject : AnyObject]!, context: UnsafePointer<()>) {
        var textView:UITextView = object as UITextView
        moveTextView(textView, toNewY: getVerticalCenterForTextView(textView))
    }
    */
    
    
    func getVerticalCenterForTextView(textView:UITextView) -> CGFloat{
        
        var textTop:CGFloat = ((Global.sharedInstance.screenHeight*0.8) - textView.contentSize.height) / 2
        
        if (ApplicationState.sharedInstance.currentState == ApplicationState.sharedInstance.STATE_PROLOG ||
            ApplicationState.sharedInstance.currentState == ApplicationState.sharedInstance.STATE_PROLOG_LAST_PAGE){
        
            textTop /= 0.8
        
        } else {
            
            textTop /= 1.6
        
        }
        
        return textTop
    }
    
    //MARK: show / hide
    
    func show(){
        
        //hide alpha
        self.view.alpha = 0
        
        //add to parent
        parentView.addSubview(self.view)
        
        //fade in
        UIView.animateWithDuration(Global.sharedInstance.FADEIN, delay: 0.0, options:UIViewAnimationOptions.CurveEaseInOut,
            
            animations: {
                self.view.alpha = 1
            }, completion: {(value: Bool) in
                
            }
            
        )
        
    }
    
    func hide(){
        
        //fade out
        UIView.animateWithDuration(Global.sharedInstance.FADEOUT, delay: 0.0, options:UIViewAnimationOptions.CurveEaseInOut,
            
            animations: {
                self.view.alpha = 0
            }, completion: {(value: Bool) in
                self.view.removeFromSuperview()
            }
            
        )
        
    }

    

        
}
 