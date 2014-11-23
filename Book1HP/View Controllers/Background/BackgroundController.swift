//
//  BackgroundController.swift
//  Book1HP
//
//  Created by Jason Snell on 6/10/14.
//  Copyright (c) 2014 HKI. All rights reserved.
//

import UIKit


class BackgroundController: UIViewController {
    
    //sub classes
    var _scroll:Scroll = Scroll()
    var _title:Title = Title()
    var _intro:Intro = Intro()
    
    //shared assets
    var scrollImg:UIImage = UIImage()
    var spaceImg:UIImage = UIImage()
    
    //views
    var spaceView:UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        * Background controller. Includes fixed space image. that can have it's own folder of view controllers. or can they have the same one? what do they do? they are SCREEN layer blend. They animate xy, scale, and fade in, out.
        
        Includes end animation with boy and medallion. This also includes the scroll. The edges change width and anim from center to outside edges. Center has a mask which opens up with the animation edges. Anim goes both in and out.
        
        Includes boy and maked boy, and titles. boy is OVERLAY layer blend. Masked by is normal. Both fade in and out. Titles are normal, fade in / out. Timed to fade out, or can receive tap/swipe gesture to move on (need "Get started!" button?)
        */
        
        //create root view
        self.view = UIView(frame: CGRectMake(
            0, 0,
            Global.sharedInstance.screenWidth, Global.sharedInstance.screenHeight
        ))
        
        //space back - foundation images of all backgrounds
        spaceImg = UIImage(named: "space_bg")!
        spaceView = UIImageView(image: spaceImg)
        self.view.addSubview(spaceView)
        
        //scroll
        scrollImg = UIImage(named: "scroll")!
        _scroll.initWithView(self.view)
        _scroll.scrollImg = scrollImg
        
        //title
        _title.initWithView(self.view)
        _title.scrollImg = scrollImg
        
        //intro
        _intro.initWithView(self.view)
        _intro.spaceImg = spaceImg
        
    }
    
    //MARK: state changes
    
    func showIntro(){
        _intro.show()
    }
    
    func openScroll(){
        
        _scroll.show()
        _title.show()
        
    }
    
    func closeScroll(){
        _scroll.hide()
    }
    
    func reset(){
        println("reset bg - do anything here???")
    }
    
}