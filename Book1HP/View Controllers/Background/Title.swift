//
//  Title.swift
//  Book1HP
//
//  Created by Jason Snell on 7/9/14.
//  Copyright (c) 2014 HKI. All rights reserved.
//

import UIKit
import QuartzCore

class Title:NSObject {
    
    //base view to attach graphics to
    var baseView:UIView = UIView()
    
    //shared assets
    var scrollImg:UIImage = UIImage()
    
    //views
    var boyOverlayView:UIImageView = UIImageView()
    var boyView:UIImageView = UIImageView()
    var titleView:UIImageView = UIImageView()
    var bookLabelView:UIImageView = UIImageView()
    
    func initWithView(_baseView:UIView){
        baseView = _baseView
    }
    
    
    func show(){
        
        addBoy()
        addTitle()
        
        GraphicsManager.sharedInstance.fadeInView(boyOverlayView, withDuration: 3.0, withDelay: 0.25)
        GraphicsManager.sharedInstance.fadeInView(boyView, withDuration: 4.0, withDelay: 2.5)
        GraphicsManager.sharedInstance.fadeInView(titleView, withDuration: 1.0, withDelay: 5.0)
        GraphicsManager.sharedInstance.fadeInView(bookLabelView, withDuration: 1.0, withDelay: 5.5)
        
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
        
        GraphicsManager.sharedInstance.fadeOutAndRemoveView(boyOverlayView, withDuration: 3.25, withDelay: 0.0)
        GraphicsManager.sharedInstance.fadeOutAndRemoveView(boyView, withDuration: 1.75, withDelay: 0.0)
        GraphicsManager.sharedInstance.fadeOutAndRemoveView(titleView, withDuration: 0.55, withDelay: 0.0)
        GraphicsManager.sharedInstance.fadeOutAndRemoveView(bookLabelView, withDuration: 0.35, withDelay: 0.0)
        
        
    }
    
    func titleAnimComplete(){
        
        Global.sharedInstance.bg = Global.sharedInstance.SCROLL
        NSNotificationCenter.defaultCenter().postNotificationName("titleAnimComplete", object: self)
        
    }
    
    //MARK: init
    
    
    func addBoy(){
        
        //boy overlay
        let boyImg:UIImage = UIImage(named: "boy_masked")!
        let boyOverlayImg:UIImage = GraphicsManager.sharedInstance.blendBackground(scrollImg, andForeground: boyImg, withBlendMode: kCGBlendModeOverlay, withAlpha: 1.0)
        boyOverlayView = UIImageView(image:boyOverlayImg)
        boyOverlayView.frame = CGRectMake(
            0,
            20,
            boyOverlayView.frame.width,
            boyOverlayView.frame.height)
        
        boyOverlayView.hidden = true
        baseView.addSubview(boyOverlayView)
        
        //boy normal
        boyView = UIImageView(image:boyImg)
        boyView.frame = CGRectMake(0, 20, boyView.frame.width, boyView.frame.height)
        boyView.hidden = true
        baseView.addSubview(boyView)
        
    }
    
    func addTitle(){
        
        //title
        let titleImg:UIImage = UIImage(named:"title_hp")!
        titleView = UIImageView(image: titleImg)
        titleView.frame = CGRectMake(
            ((Global.sharedInstance.screenWidth / 2) - (titleView.frame.width / 2)),
            (Global.sharedInstance.screenHeight - 230),
            titleView.frame.width,
            titleView.frame.height)
        titleView.hidden = true
        baseView.addSubview(titleView)
        
        //book label
        let bookLabelImg:UIImage = UIImage(named:"title_book1")!
        bookLabelView = UIImageView(image: bookLabelImg)
        bookLabelView.frame = CGRectMake(
            ((Global.sharedInstance.screenWidth / 2) - (bookLabelView.frame.width / 2)),
            (Global.sharedInstance.screenHeight - 85),
            bookLabelView.frame.width,
            bookLabelView.frame.height)
        bookLabelView.hidden = true
        baseView.addSubview(bookLabelView)
    }    
    
}
