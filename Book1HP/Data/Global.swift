//
//  GlobalVariables.swift
//  Book1HP
//
//  Created by Jason Snell on 6/10/14.
//  Copyright (c) 2014 HKI. All rights reserved.
//

import UIKit

let GlobalSharedInstance = Global();

class Global {
    
    var bg:Int
    let SPACE:Int = 0
    let SCROLL:Int = 1
    
    var swipeOK:Bool = true
    
    let screenHeight:CGFloat
    let screenWidth:CGFloat
    
    let FADEIN:NSTimeInterval = 0.9
    let FADEOUT:NSTimeInterval = 0.1
    
    var currPage:Int = 0;
    
    class var sharedInstance:Global {
        return GlobalSharedInstance;
    }
    
    init(){
        
        bg = SPACE
        
        let screenSize:CGRect = UIScreen.mainScreen().bounds
        
        var h = CGFloat(screenSize.height);
        var w = CGFloat(screenSize.width);
        
        if (w < h) {
            screenHeight = w
            screenWidth = h
        } else {
            screenHeight = h
            screenWidth = w
        }
        
    }
    
}

