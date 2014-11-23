//
//  ButtonController.swift
//  Book1HP
//
//  Created by Jason Snell on 6/10/14.
//  Copyright (c) 2014 HKI. All rights reserved.
//

import UIKit

class ForegroundController: UIViewController, UIGestureRecognizerDelegate {
    
    //sub controllers
    let drawingController: DrawingController = DrawingController()
    let textController: TextController = TextController()
    let buttons:Buttons = Buttons()
    
    //swipe instructions
    var instructionsComplete:Bool = false
    var swipeInstructions:UIImageView = UIImageView()
    var swipeLeftRecognizer:UISwipeGestureRecognizer = UISwipeGestureRecognizer()
    var swipeRightRecognizer:UISwipeGestureRecognizer = UISwipeGestureRecognizer()
    
    
    
    var swipeOK:Bool = true
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //set up foreground listeners 
        setUpListeners()
        
        //create root view
        self.view = UIView(frame: CGRectMake(0, 0, Global.sharedInstance.screenWidth, Global.sharedInstance.screenHeight));
        
        //send ref to subs, since the views are being removed and added during app interactions
        //note: since the drawing can be CPU intensive, removing the text controller view during drawing helps performance
        //these 2 views take turns being on stage, being added and removed as they appear and hide
        //beacause of this, the buttons set needs to be removed and added too in order to stay on top and be tap accessible
        
        drawingController.parentView = self.view
        textController.parentView = self.view
        buttons.initWithView(self.view)
        
        //swipes
        initSwipes()
        
    }
    
    //MARK: listeners
    
    func setUpListeners(){
        
        //when text is done animating after it's been swiped
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "swipeTextComplete",
            name: "swipeTextComplete",
            object: nil)
        
        //button taps
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "transDrawingToStoryInterface",
            name: "tapBackButton",
            object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "transStoryToDrawingInterface",
            name: "tapDrawButton",
            object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "swipeLeft",
            name: "tapHonorButton",
            object: nil)
        
    }
    
    //MARK: state changes
    
    func transDrawingToStoryInterface(){
        hideDrawingInterface()
        showStoryInterface()
    }
    
    func transStoryToDrawingInterface(){
        hideStoryInterface()
        showDrawingInterface()
    }
    
    //story interface
    func showStoryInterface(){
        
        textController.show()
        fadeIn(buttons.drawBtn.view)
        NSNotificationCenter.defaultCenter().postNotificationName("drawingButtonWillAppear", object: self)
        
    }
    
    func hideStoryInterface(){
        
        textController.hide()
        fadeOut(buttons.drawBtn.view)
        
    }

    
    //drawing interface
    
    func showDrawingInterface(){
        
        //disable swipes
        disableSwipes()
        
        //show drawing controller and it's view
        drawingController.show()
        
        //move buttons on top of drawing interface
        buttons.moveToTop()
        
        //drawing buttons
        fadeIn(buttons.backBtn)
        fadeIn(buttons.undoBtn)
        fadeIn(buttons.startOverBtn)
        fadeIn(buttons.saveBtn)
        
    }
    
    func hideDrawingInterface(){
        
        fadeOut(buttons.backBtn)
        fadeOut(buttons.undoBtn)
        fadeOut(buttons.startOverBtn)
        fadeOut(buttons.saveBtn)
        
        drawingController.closeCanvas()
        drawingController.hide()
        
        //re-add swipes
        enableSwipes()
    
    }
    
    func showStoryLastPage(){
        
        fadeOut(buttons.drawBtn.view)
        fadeIn(buttons.honorBtn)
        
    }
    
    func hideStoryLastPage(){
        fadeOut(buttons.honorBtn)
    }
    
    func showEnd(){
        
        textController.show()
        fadeIn(buttons.readAgainBtn)
    
    }
    
    func hideEnd(){
        fadeOut(buttons.readAgainBtn)
    }

    
    
    
    //MARK: Swipes
    
    func initSwipes(){
        
        swipeLeftRecognizer = UISwipeGestureRecognizer(
            target:self,
            action:Selector("swipeLeft"))
        swipeLeftRecognizer.direction = .Left
        view.addGestureRecognizer(swipeLeftRecognizer)
        
        swipeRightRecognizer = UISwipeGestureRecognizer(
            target:self,
            action:Selector("swipeRight"))
        swipeRightRecognizer.direction = .Right
        view.addGestureRecognizer(swipeRightRecognizer)

    }
    
    func enableSwipes(){
        view.addGestureRecognizer(swipeLeftRecognizer)
        view.addGestureRecognizer(swipeRightRecognizer)
    }
    
    func disableSwipes(){
        view.removeGestureRecognizer(swipeLeftRecognizer)
        view.removeGestureRecognizer(swipeRightRecognizer)
    }
    
    func swipeLeft(){
        if (swipeOK){
            NSNotificationCenter.defaultCenter().postNotificationName("swipeLeftGesture", object: self)
        }
    }
    
    func swipeRight(){
        if (swipeOK){
            NSNotificationCenter.defaultCenter().postNotificationName("swipeRightGesture", object: self)
        }
    }
    
    func swipeTextComplete(){
        swipeOK = true
    }
    
    
    //MARK: instructions
    
    func showInstructions(){
        
        //add graphics
        let swipeInstructionsImg:UIImage = UIImage(named: "arrow_swipe")!
        swipeInstructions = UIImageView(image:swipeInstructionsImg)
        swipeInstructions.frame = CGRectMake(
            (Global.sharedInstance.screenWidth/2) - (swipeInstructions.frame.width/2),
            (Global.sharedInstance.screenHeight/2) - (swipeInstructions.frame.height/2),
            swipeInstructions.frame.width,
            swipeInstructions.frame.height)
        
        swipeInstructions.alpha = 0
        self.view.addSubview(swipeInstructions)
        
        //show them
        fadeIn(swipeInstructions)
    }
    
    func hideInstructions(){
        
        UIView.animateWithDuration(0.4, delay: 0.0, options:UIViewAnimationOptions.CurveEaseInOut,
            
            animations: {
                
                //move and hide curr off to left side
                self.swipeInstructions.frame = CGRectMake(
                    -(self.swipeInstructions.frame.width),
                    (Global.sharedInstance.screenHeight/2) - (self.swipeInstructions.frame.height/2),
                    self.swipeInstructions.frame.width,
                    self.swipeInstructions.frame.height)
                self.swipeInstructions.alpha = 0
                
            }, completion: {(value: Bool) in
                
                self.swipeInstructions.removeFromSuperview()
                
            }
        )
        
    }

    
    //MARK: anim functions
    func fadeIn(v:UIView){
        v.alpha = 0
        v.hidden = false
        
        UIView.animateWithDuration(Global.sharedInstance.FADEIN, delay: 0.0, options:UIViewAnimationOptions.CurveEaseInOut,
            
            animations: {
                v.alpha = 1
            }, completion: {(value: Bool) in }
        )
    }
    
    func fadeOut(v:UIView){
        
        UIView.animateWithDuration(Global.sharedInstance.FADEOUT, delay: 0.0, options:UIViewAnimationOptions.CurveEaseInOut,
            
            animations: {
                v.alpha = 0
            }, completion: {(value: Bool) in
                v.hidden = true
            }
        )
    }


}