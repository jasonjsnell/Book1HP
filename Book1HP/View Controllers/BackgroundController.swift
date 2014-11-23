//
//  BackgroundController.swift
//  Book1HP
//
//  Created by Jason Snell on 6/10/14.
//  Copyright (c) 2014 HKI. All rights reserved.
//

import UIKit
import QuartzCore

class BackgroundController: UIViewController {
    
    var spaceImg:UIImage = UIImage()
    var spaceView:UIImageView = UIImageView()
    var acView:UIImageView = UIImageView()
    var scrollImg:UIImage = UIImage()
    var scrollView:UIImageView = UIImageView()
    var scrollRollView:UIImageView = UIImageView()
    var boyOverlayView:UIImageView = UIImageView()
    var boyView:UIImageView = UIImageView()
    var titleView:UIImageView = UIImageView()
    var bookLabelView:UIImageView = UIImageView()
    var scrollMask:CALayer = CALayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        * Background controller. Includes fixed space image. that can have it's own folder of view controllers. or can they have the same one? what do they do? they are SCREEN layer blend. They animate xy, scale, and fade in, out.
        
        Includes end animation with boy and medallion. This also includes the scroll. The edges change width and anim from center to outside edges. Center has a mask which opens up with the animation edges. Anim goes both in and out.
        
        Includes boy and maked boy, and titles. boy is OVERLAY layer blend. Masked by is normal. Both fade in and out. Titles are normal, fade in / out. Timed to fade out, or can receive tap/swipe gesture to move on (need "Get started!" button?)
        */
        
        //create root view
        self.view = UIView(frame: CGRectMake(
            0,
            0,
            Global.sharedInstance.screenWidth,
            Global.sharedInstance.screenHeight))
        
        initSpace()
        
    }
    
    //MARK: public methods
    
    func showIntro(){
        animAC()
    }
    
    func openScroll(){
        
        addScroll()
        
        var scrollTimer = NSTimer.scheduledTimerWithTimeInterval(0.25,
            target: self,
            selector: Selector("openScrollAnim"),
            userInfo: nil,
            repeats: false)
        
        titleAnim()
        
    }
    
    func closeScroll(){
        closeScrollAnim()
    }
    
    func reset(){
        println("reset bg - do anything here???")
    }
    
    //MARK:animations
    
    func fadeInView(imageView:UIImageView, withDuration duration:NSTimeInterval, withDelay delay:NSTimeInterval){
        
        imageView.alpha = 0
        imageView.hidden = false
        
        UIView.animateWithDuration(duration, delay: delay, options:UIViewAnimationOptions.CurveEaseInOut,
            
            animations: {
            
                imageView.alpha = 1
                
            }, completion: {(value: Bool) in
            
            }
        )

    }
    
    func fadeOutView(imageView:UIImageView, withDuration duration:NSTimeInterval, withDelay delay:NSTimeInterval){
        
        UIView.animateWithDuration(duration, delay: delay, options:UIViewAnimationOptions.CurveEaseInOut,
            
            animations: {
                
                imageView.alpha = 0
                
            }, completion: {(value: Bool) in
 
                imageView.hidden = true
            
            }
        )
        
    }

    
    func titleAnim(){
        
        fadeInView(boyOverlayView, withDuration: 3.0, withDelay: 0.25)
        fadeInView(boyView, withDuration: 4.0, withDelay: 2.5)
        fadeInView(titleView, withDuration: 1.0, withDelay: 5.0)
        fadeInView(bookLabelView, withDuration: 1.0, withDelay: 5.5)
        
        var hideTitleTimer = NSTimer.scheduledTimerWithTimeInterval(8.0,
            target: self,
            selector: Selector("hideTitle"),
            userInfo: nil,
            repeats: false)
        
        var titleAnimCompleteTimer = NSTimer.scheduledTimerWithTimeInterval(9.0,
            target: self,
            selector: Selector("titleAnimComplete"),
            userInfo: nil,
            repeats: false)
        
    }
    
    func hideTitle(){
        
        fadeOutView(boyOverlayView, withDuration: 3.25, withDelay: 0.0)
        fadeOutView(boyView, withDuration: 1.75, withDelay: 0.0)
        fadeOutView(titleView, withDuration: 0.55, withDelay: 0.0)
        fadeOutView(bookLabelView, withDuration: 0.35, withDelay: 0.0)
        
        
    }
    
    func titleAnimComplete(){
        
        Global.sharedInstance.bg = Global.sharedInstance.SCROLL
        NSNotificationCenter.defaultCenter().postNotificationName("titleAnimComplete", object: self)
        
    }
    
    //MARK: AC
    
    func addAC(){
        //AC characters image
        let acImg:UIImage = UIImage(named: "a_and_c")
        
        let acScreenImg:UIImage = GraphicsManager.sharedInstance.blendBackground(spaceImg,
            andForeground: acImg,
            withBlendMode: kCGBlendModeScreen,
            withAlpha: 0.8)
        
        acView = UIImageView(image: acScreenImg)
        acView.alpha = 0
        self.view.addSubview(acView)
    }
    
    func animAC(){
        
        //add graphics
        addAC()
        
        UIView.animateWithDuration(4.0, delay: 1.0, options:UIViewAnimationOptions.CurveEaseInOut,
            
            animations: {
                
                self.acView.alpha = 1.0
                
            }, completion: {(value: Bool) in
                
                UIView.animateWithDuration(6.0, delay: 0.5, options:UIViewAnimationOptions.CurveEaseInOut,
                    
                    animations: {
                        
                        self.acView.alpha = 0
                        
                    }, completion: {(value: Bool) in
                        
                        self.acView.removeFromSuperview()
                        NSNotificationCenter.defaultCenter().postNotificationName("introAnimComplete", object: self)
                        
                    }
                    
                )
                
            }
        )
        
    }
    
    //MARK: scroll
    func addScroll(){
        
        //scroll parchment background
        scrollImg = UIImage(named: "scroll")
        scrollView = UIImageView(image:scrollImg)
        scrollView.frame = CGRectMake(
            0, 20,
            scrollImg.size.width, scrollImg.size.height)
        
        self.view.addSubview(scrollView)
        
        // Create your mask layer
        scrollMask = CALayer()
        scrollMask.frame = CGRectMake((
            Global.sharedInstance.screenWidth),
            1,
            20,
            Global.sharedInstance.screenHeight)
        
        scrollMask.contents = scrollImg.CGImage
        
        // Apply the mask to your uiview layer
        scrollView.layer.mask = scrollMask
        
        //http://www.raywenderlich.com/5478/uiview-animation-tutorial-practical-recipes
        
        //set up scroll in endframe position
        let scrollRollImg:UIImage = UIImage(named: "scroll_left")
        scrollRollView = UIImageView(image:scrollRollImg)
        scrollRollView.frame = CGRectMake(
            Global.sharedInstance.screenWidth, 5,
            200, scrollRollView.frame.height)
        
        self.view.addSubview(scrollRollView)
        
    }

    
    func openScrollAnim() {
        
        //animate scroll sides by reverting them to their original positions
        UIView.animateWithDuration(0.65, delay: 0.0, options:UIViewAnimationOptions.CurveEaseInOut,
            
            animations: {
                
                self.scrollRollView.frame = CGRectMake(
                    -10, 20.0,
                    10, Global.sharedInstance.screenHeight)
                
                
            }, completion: {(value: Bool) in
                self.scrollRollView.removeFromSuperview()
            }
        )
        
        
       
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.65)
        
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut))
    
        CATransaction.setCompletionBlock({(value: Void) in
            
                //scroll anim complete
                self.scrollMask.removeFromSuperlayer()
            }
        )
        
        scrollMask.frame = CGRectMake(0, 0, scrollView.frame.width, scrollView.frame.height)
       
        CATransaction.commit()
    
    }
    
    func closeScrollAnim() {
        
        //move scroll to start frame position
        scrollRollView.hidden = false;
        scrollRollView.frame = CGRectMake(
            Global.sharedInstance.screenWidth, 5,
            30, scrollRollView.frame.height)
        
        //animate
        UIView.animateWithDuration(0.8, delay: 0.0, options:UIViewAnimationOptions.CurveEaseInOut,
            
            animations: {
                
                self.scrollRollView.frame = CGRectMake(
                    -200, 5.0,
                    200, Global.sharedInstance.screenHeight)
                
            }, completion: {(value: Bool) in
                
                self.scrollRollView.removeFromSuperview()
                NSNotificationCenter.defaultCenter().postNotificationName("scrollCloseComplete", object: self)
            
            }
        )
        
        /*
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.8)
        
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut))
        
        CATransaction.setCompletionBlock({(value: Void) in
            
            //scroll anim complete
            self.scrollView.removeFromSuperview()
            self.scrollMask.removeFromSuperlayer()
            
            }
        )
        
        scrollMask.frame = CGRectMake(-100, 0, 10, scrollView.frame.height)
        
        CATransaction.commit()
        */
    }
    
    
    //MARK: setup
    
    
    
    func initSpace(){
        
        //space bg
        spaceImg = UIImage(named: "space_bg")
        spaceView = UIImageView(image: spaceImg)
        self.view.addSubview(spaceView)
        
    }
    
    
    func initBoy(){
        
        //boy overlay
        let boyImg:UIImage = UIImage(named: "boy_masked")
        let boyOverlayImg:UIImage = GraphicsManager.sharedInstance.blendBackground(scrollImg, andForeground: boyImg, withBlendMode: kCGBlendModeOverlay, withAlpha: 1.0)
        boyOverlayView = UIImageView(image:boyOverlayImg)
        boyOverlayView.frame = CGRectMake(
            0,
            20,
            boyOverlayView.frame.width,
            boyOverlayView.frame.height)
        
        boyOverlayView.hidden = true
        self.view.addSubview(boyOverlayView)
        
        //boy normal
        boyView = UIImageView(image:boyImg)
        boyView.frame = CGRectMake(0, 20, boyView.frame.width, boyView.frame.height)
        boyView.hidden = true
        self.view.addSubview(boyView)
        
    }
    
    func initTitle(){
        
        //title
        let titleImg:UIImage = UIImage(named:"title_hp")
        titleView = UIImageView(image: titleImg)
        titleView.frame = CGRectMake(
            ((Global.sharedInstance.screenWidth / 2) - (titleView.frame.width / 2)),
            (Global.sharedInstance.screenHeight - 230),
            titleView.frame.width,
            titleView.frame.height)
        titleView.hidden = true
        self.view.addSubview(titleView)
        
        //book label
        let bookLabelImg:UIImage = UIImage(named:"title_book1")
        bookLabelView = UIImageView(image: bookLabelImg)
        bookLabelView.frame = CGRectMake(
            ((Global.sharedInstance.screenWidth / 2) - (bookLabelView.frame.width / 2)),
            (Global.sharedInstance.screenHeight - 85),
            bookLabelView.frame.width,
            bookLabelView.frame.height)
        bookLabelView.hidden = true
        self.view.addSubview(bookLabelView)
    }
   
}