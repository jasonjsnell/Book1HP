//
//  Scroll.swift
//  Book1HP
//
//  Created by Jason Snell on 7/9/14.
//  Copyright (c) 2014 HKI. All rights reserved.
//

import UIKit
import QuartzCore

class Scroll:NSObject {
    
    //base view to attach graphics to
    var baseView:UIView = UIView()
    
    //shared assets
    var scrollImg:UIImage = UIImage()
    
    //views
    var scrollView:UIImageView = UIImageView()
    var scrollRollView:UIImageView = UIImageView()
    var scrollMask:CALayer = CALayer()
    
    func initWithView(_baseView:UIView){
        baseView = _baseView
    }
    
    //show methods
    func show() {
        
        //seperate these actions by a split second so the build has time to render and apply the mask before animating it
        addScroll()
        
        var scrollTimer = NSTimer.scheduledTimerWithTimeInterval(0.25,
            target: self,
            selector: Selector("animScroll"),
            userInfo: nil,
            repeats: false)
        
    }
    
    func addScroll(){
        
        scrollView = UIImageView(image:scrollImg)
        scrollView.frame = CGRectMake(
            0, 20,
            scrollImg.size.width, scrollImg.size.height)
        
        baseView.addSubview(scrollView)
        
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
        
        //set up scroll in endframe position
        let scrollRollImg:UIImage = UIImage(named: "scroll_left")!
        scrollRollView = UIImageView(image:scrollRollImg)
        scrollRollView.frame = CGRectMake(
            Global.sharedInstance.screenWidth, 5,
            200, scrollRollView.frame.height)
        
        baseView.addSubview(scrollRollView)
        
        
    }
    
    func animScroll(){
        
        //animation roll
        UIView.animateWithDuration(0.65, delay: 0.0, options:UIViewAnimationOptions.CurveEaseInOut,
            
            animations: {
                
                self.scrollRollView.frame = CGRectMake(
                    -10, 20.0,
                    10, Global.sharedInstance.screenHeight)
                
                
            }, completion: {(value: Bool) in
                self.scrollRollView.removeFromSuperview()
            }
        )
        
        //animation bg and mask
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

    //hide
    func hide() {
        
        
        //move scroll to start frame position
        
        scrollRollView.frame = CGRectMake(
            Global.sharedInstance.screenWidth, 5,
            30, scrollRollView.frame.height)
        baseView.addSubview(scrollRollView)
        
        //animate roll
        UIView.animateWithDuration(0.65, delay: 0.0, options:UIViewAnimationOptions.CurveEaseInOut,
            
            animations: {
                
                self.scrollRollView.frame = CGRectMake(
                    -120, 20.0,
                    120, Global.sharedInstance.screenHeight)
                
                
            }, completion: {(value: Bool) in
                self.scrollRollView.removeFromSuperview()
            }
        )

        
        // Apply the mask to your uiview layer
        scrollView.layer.mask = scrollMask
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.65)
        
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseInEaseOut))
        
        CATransaction.setCompletionBlock({(value: Void) in
            
            //scroll anim complete
            self.scrollMask.removeFromSuperlayer()
            self.scrollView.removeFromSuperview()
            NSNotificationCenter.defaultCenter().postNotificationName("scrollCloseComplete", object: self)
            }
        )
        
        scrollMask.frame = CGRectMake(-1, 0, 1, scrollView.frame.height)
        
        CATransaction.commit()

        
    }


}
