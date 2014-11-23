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
    
}

