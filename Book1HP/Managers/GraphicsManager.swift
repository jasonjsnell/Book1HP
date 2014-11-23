//
//  GraphicsManager.swift
//  Book1HP
//
//  Created by Jason Snell on 6/10/14.
//  Copyright (c) 2014 HKI. All rights reserved.
//

import UIKit

let GraphicsManagerSharedInstance = GraphicsManager();

class GraphicsManager {
    
    
    
    class var sharedInstance:GraphicsManager {
        return GraphicsManagerSharedInstance;
    }
    
    init(){
        
    }

    //MARK: rendering
    func
        
        blendBackground(background:UIImage,
        andForeground foreground:UIImage,
        withBlendMode blendMode:CGBlendMode,
        withAlpha alpha:CGFloat)
       
        -> UIImage
    
    {
        
        UIGraphicsBeginImageContext(background.size);
        
        var bounds:CGRect = CGRectMake(0, 0, background.size.width, background.size.height);
        background.drawInRect(bounds);
        foreground.drawInRect(bounds, blendMode: blendMode, alpha: alpha);
        
        var blendImage:UIImage = UIGraphicsGetImageFromCurrentImageContext();
       
        UIGraphicsEndImageContext();
        
        return blendImage;
    }
    
    //MARK: fade in / out
    func
        
        fadeInView(imageView:UIImageView,
        withDuration duration:NSTimeInterval,
        withDelay delay:NSTimeInterval)
    
    {
        
        imageView.alpha = 0
        imageView.hidden = false
        
        UIView.animateWithDuration(duration, delay: delay, options:UIViewAnimationOptions.CurveEaseInOut,
            
            animations: {
                
                imageView.alpha = 1
                
            }, completion: {(value: Bool) in
                
            }
        )
        
    }
    
    func
        
        fadeOutAndRemoveView(imageView:UIImageView,
        withDuration duration:NSTimeInterval,
        withDelay delay:NSTimeInterval)
    
    {
        
        UIView.animateWithDuration(duration, delay: delay, options:UIViewAnimationOptions.CurveEaseInOut,
            
            animations: {
                
                imageView.alpha = 0
                
            }, completion: {(value: Bool) in
                
                imageView.removeFromSuperview()
                
            }
        )
        
    }

    
}

