//
//  Intro.swift
//  Book1HP
//
//  Created by Jason Snell on 7/9/14.
//  Copyright (c) 2014 HKI. All rights reserved.
//

import UIKit
import QuartzCore

class Intro:NSObject {
    
    //base view to attach graphics to
    var baseView:UIView = UIView()
    
    //shared assets
    var spaceImg:UIImage = UIImage()
    
    //views
    var acView:UIImageView = UIImageView()

    func initWithView(_baseView:UIView){
        baseView = _baseView
    }
    
    //MARK: show
    
    func show(){
        
        //add graphics
        add()
        
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
    
    //init
    func add(){
        //AC characters image
        let acImg:UIImage = UIImage(named: "a_and_c")!
        
        let acScreenImg:UIImage = GraphicsManager.sharedInstance.blendBackground(spaceImg,
            andForeground: acImg,
            withBlendMode: kCGBlendModeScreen,
            withAlpha: 0.8)
        
        acView = UIImageView(image: acScreenImg)
        acView.alpha = 0
        baseView.addSubview(acView)
    }
    
    

    
    
}