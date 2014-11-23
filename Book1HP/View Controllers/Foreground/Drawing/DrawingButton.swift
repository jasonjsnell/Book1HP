//
//  DrawingButton.swift
//  Book1HP
//
//  Created by Jason Snell on 7/10/14.
//  Copyright (c) 2014 HKI. All rights reserved.
//

import UIKit

class DrawingButton:UIViewController {
    
    var iconView:UIImageView = UIImageView()
    var artView:UIImageView = UIImageView()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //init elements of button
        var buttonImg:UIImage = UIImage(named: "draw_circle_red")!
        var buttonView:UIImageView = UIImageView(image: buttonImg)
        var buttonHitArea:UIButton = UIButton(frame: CGRectMake(
            0, 0,
            buttonImg.size.width, buttonImg.size.height))
        buttonHitArea.addTarget(self, action: "tapDrawBtn:", forControlEvents: UIControlEvents.TouchUpInside)
        
        //pencil icon - shows when there is no artwork
        var iconImg:UIImage = UIImage(named: "draw_icon_red")!
        iconView = UIImageView(image: iconImg)
        iconView.frame = CGRectMake(
            (buttonImg.size.width / 2) - (iconImg.size.width / 2) + (buttonImg.size.width * 0.025),
            buttonImg.size.height * 0.14,
            iconImg.size.width,
            iconImg.size.height)
        iconView.alpha = 0
        
        //art thumbnail - shows when there is artwork
        var pctRatio:CGFloat = ((100 * Global.sharedInstance.screenHeight ) / Global.sharedInstance.screenWidth) / 100
        var circleWidthAndHeight:CGFloat = buttonImg.size.width
        var artHeight:CGFloat = circleWidthAndHeight * pctRatio
     
        artView.frame = CGRectMake(
            0, buttonImg.size.height * 0.1,
            circleWidthAndHeight,
            artHeight)
        artView.alpha = 0
        
        //create root view
        self.view = UIView(frame: CGRectMake(
            (Global.sharedInstance.screenWidth/2) - (buttonImg.size.width / 2),
            (Global.sharedInstance.screenHeight * 0.9) - (buttonImg.size.height),
            buttonImg.size.width,
            buttonImg.size.height));
        
        //add views with button on top
        self.view.addSubview(iconView)
        self.view.addSubview(artView)
        self.view.addSubview(buttonView)
        self.view.addSubview(buttonHitArea)
        
        
    }
    
    //MARK: public / tap and check for user art
    
    func tapDrawBtn(sender: UIButton!) {
        NSNotificationCenter.defaultCenter().postNotificationName("tapDrawButton", object: self)
    }
    
    func checkForUserArtwork(){
        
        var artID:Int = Global.sharedInstance.currPage
        
        if (GraphicsData.sharedInstance.isThereArtworkWithID(artID)){
            
            //hide icon, show art
            iconView.alpha = 0
            showArtwork(GraphicsData.sharedInstance.getArtworkWithID(Global.sharedInstance.currPage))
            
            
        } else {
            
            //hide art, show icon
            artView.alpha = 0
            showIcon()
        }
        
    }
    
    //MARK: private / view changes

    private func showArtwork(image:UIImage){
        
        //hide
        artView.alpha = 0
        
        //assign image
        artView.image = image
        
        //fade in
        UIView.animateWithDuration(Global.sharedInstance.FADEIN, delay: 0.0, options:UIViewAnimationOptions.CurveEaseInOut,
            
            animations: {
                self.artView.alpha = 1
            }, completion: {(value: Bool) in }
        )
    }
    
    private func showIcon(){
        
        //if icon is not showing, fade it in
        if (iconView.alpha == 0){
            UIView.animateWithDuration(Global.sharedInstance.FADEIN, delay: 0.0, options:UIViewAnimationOptions.CurveEaseInOut,
                
                animations: {
                    self.iconView.alpha = 1
                }, completion: {(value: Bool) in }
            )
        }
    }
    
    
    
    
}
