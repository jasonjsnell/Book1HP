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
    
    let mode:Int;
    let screenHeight:CGFloat;
    let screenWidth:CGFloat;
    var currPage = 1;
    
    class var sharedInstance:Global {
        return GlobalSharedInstance;
    }
    
    init(){
        mode = 0;
        let screenSize:CGRect = UIScreen.mainScreen().bounds
        screenHeight = CGFloat(screenSize.height);
        screenWidth = CGFloat(screenSize.width);
        
    }
    
}

