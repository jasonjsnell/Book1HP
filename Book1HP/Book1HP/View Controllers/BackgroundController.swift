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
    
    var acView:UIImageView?
    var scrollView:UIImageView?
    var scrollLeftView:UIImageView?
    var scrollRightView:UIImageView?
    var boyOverlayView:UIImageView?
    var boyView:UIImageView?
    var titleView:UIImageView?
    var bookLabelView:UIImageView?
    var scrollMask:CALayer?
    
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
        
        //space bg
        let spaceImg:UIImage = UIImage(named: "space_bg")
        let spaceView:UIImageView = UIImageView(image: spaceImg)
        self.view.addSubview(spaceView)
        
        //AC characters image
        let acImg:UIImage = UIImage(named: "a_and_c")
        
        let acScreenImg:UIImage = GraphicsManager.sharedInstance.blendBackground(spaceImg,
            andForeground: acImg,
            withBlendMode: kCGBlendModeScreen,
            withAlpha: 0.8)
        
        acView = UIImageView(image: acScreenImg)
        acView!.alpha = 0
        self.view.addSubview(acView)
        
        //scroll parchment background
        let scrollImg:UIImage = UIImage(named: "scroll")
        scrollView = UIImageView(image:scrollImg)
        scrollView!.frame = CGRectMake(
            0,
            20,
            scrollView!.frame.width,
            scrollView!.frame.height)
        
        scrollView!.hidden = true
        self.view.addSubview(scrollView)
        
        // Create your mask layer
        scrollMask = CALayer()
        scrollMask!.frame = CGRectMake((
            Global.sharedInstance.screenWidth / 2),
            20,
            1,
            Global.sharedInstance.screenHeight)
        
        scrollMask!.contents = scrollImg.CGImage
        
        // Apply the mask to your uiview layer
        scrollView!.layer.mask = scrollMask
        
        //http://www.raywenderlich.com/5478/uiview-animation-tutorial-practical-recipes
        //http://stackoverflow.com/questions/19181672/how-can-i-animate-x-y-height-width-and-rotation-in-ios
        
        //set up scroll in endframe position
        let scrollLeftImg:UIImage = UIImage(named: "scroll_left")
        scrollLeftView = UIImageView(image:scrollLeftImg)
        scrollLeftView!.frame = CGRectMake(
            -(scrollLeftView!.frame.width),
            10,
            scrollLeftView!.frame.width,
            scrollLeftView!.frame.height)
        
        scrollLeftView!.hidden = true
        self.view.addSubview(scrollLeftView)
        
        let scrollRightImg:UIImage = UIImage(named: "scroll_left")
        scrollRightView = UIImageView(image:scrollRightImg)
        scrollRightView!.frame = CGRectMake(
            Global.sharedInstance.screenWidth,
            5,
            scrollRightView!.frame.width,
            scrollRightView!.frame.height)
        
        scrollRightView!.hidden = true
        self.view.addSubview(scrollRightView)
        
        //boy overlay
        let boyImg:UIImage = UIImage(named: "boy_masked")
        let boyOverlayImg:UIImage = GraphicsManager.sharedInstance.blendBackground(scrollImg, andForeground: boyImg, withBlendMode: kCGBlendModeOverlay, withAlpha: 1.0)
        boyOverlayView = UIImageView(image:boyOverlayImg)
        boyOverlayView!.frame = CGRectMake(
            0,
            20,
            boyOverlayView!.frame.width,
            boyOverlayView!.frame.height)
        
        boyOverlayView!.hidden = true
        self.view.addSubview(boyOverlayView)
        
        //boy normal
        boyView = UIImageView(image:boyImg)
        boyView!.frame = CGRectMake(0, 20, boyView!.frame.width, boyView!.frame.height)
        boyView!.hidden = true
        self.view.addSubview(boyView)
        
        //title
        let titleImg:UIImage = UIImage(named:"title_hp")
        titleView = UIImageView(image: titleImg)
        titleView!.frame = CGRectMake(
            ((Global.sharedInstance.screenWidth / 2) - (titleView!.frame.width / 2)),
            (Global.sharedInstance.screenHeight - 230),
            titleView!.frame.width,
            titleView!.frame.height)
        titleView!.hidden = true
        self.view.addSubview(titleView)
        
        //book label
        let bookLabelImg:UIImage = UIImage(named:"title_book1")
        bookLabelView = UIImageView(image: bookLabelImg)
        bookLabelView!.frame = CGRectMake(
            ((Global.sharedInstance.screenWidth / 2) - (bookLabelView!.frame.width / 2)),
            (Global.sharedInstance.screenHeight - 85),
            bookLabelView!.frame.width,
            bookLabelView!.frame.height)
        bookLabelView!.hidden = true
        self.view.addSubview(bookLabelView)
        
        
        //var timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("openScrollAnim"), userInfo: nil, repeats: false)

        
        //acIntroAnim()
        
    }
    
    //animate A & C in and out
    
    func acIntroAnim(){
        
        
        UIView.animateWithDuration(4.0, delay: 1.0, options:UIViewAnimationOptions.CurveEaseInOut,
            
            animations: {
            
                self.acView!.alpha = 1.0
            
            }, completion: {(value: Bool) in
                
                UIView.animateWithDuration(6.0, delay: 0.5, options:UIViewAnimationOptions.CurveEaseInOut,
                    
                    animations: {
                        
                        self.acView!.alpha = 0
                        
                    }, completion: nil
                
                )
                
            }
        )
        
    }
    
    func openScrollAnim() {
        
        //show scroll pieces
        scrollView!.hidden = false
        scrollLeftView!.hidden = false;
        scrollRightView!.hidden = false;
        
        //move scroll to start frame position
        scrollLeftView!.transform = CGAffineTransformTranslate(
            scrollLeftView!.transform,
            (Global.sharedInstance.screenWidth / 2) + 50,
            10)
        scrollLeftView!.transform = CGAffineTransformScale(
            scrollLeftView!.transform,
            0.1,
            1.0)
        scrollRightView!.transform = CGAffineTransformTranslate(
            scrollRightView!.transform,
            -(Global.sharedInstance.screenWidth / 2) - 50,
            10.0);
        scrollRightView!.transform = CGAffineTransformScale(
            scrollRightView!.transform,
            0.1,
            1.0);
        
        //animation scroll by reverting it to original position
        
        UIView.animateWithDuration(0.7, delay: 0.0, options:UIViewAnimationOptions.CurveEaseInOut,
            
            animations: {
                
                var t:CGAffineTransform = CGAffineTransformIdentity
                self.scrollLeftView!.transform = t
                self.scrollRightView!.transform = t
                
            }, completion: {(value: Bool) in
                
                println("Scroll left anim complete")
                
            }
        )
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.65)
        
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut))
    
        CATransaction.setCompletionBlock({(value: Void) in
            
                println("Scroll mask anim complete")
            }
        )
        
       
        scrollMask!.frame = CGRectMake(0, 20, scrollView!.frame.width, scrollView!.frame.height)
       
        CATransaction.commit()
    }
    /*
    
    
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.6f];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [CATransaction setCompletionBlock:^{
    NSLog(@"Scroll mask anim complete");
    }];
    
    //scrollMask.position = CGPointMake(0, 0);
    scrollMask.frame = (CGRect){{0, 20}, scrollView.frame.size};
    
    }
    
    
    */
}