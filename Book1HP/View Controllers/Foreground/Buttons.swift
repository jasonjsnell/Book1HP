//
//  Buttons.swift
//  Book1HP
//
//  Created by Jason Snell on 7/7/14.
//  Copyright (c) 2014 HKI. All rights reserved.
//

import UIKit

class Buttons:NSObject {
    
    /*
    I created this as a set of floating UIButtons so that it doesn't have a background base view that blocks interactions going to the views below. These buttons need to sit on top of the drawing and text interfaces, but not block them. The drawing interface needs pan gesture inputs for the drawings and the text interface needs swipes to turn the pages
    
    The drawing button is different that the others because the graphic inside the circle can either be an penicl icon or a small view rendering of the user's artwork (after it's been created). I made it a custom UIViewController to incorporate that added functionatlity. The rest of the buttons are normal UIButtons
    */
    
    //base view to attach graphics to
    var baseView:UIView = UIView()
    
    //interface buttons
    var drawBtn:DrawingButton = DrawingButton()
    var backBtn:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
    var undoBtn:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
    var startOverBtn:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
    var saveBtn:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
    var honorBtn:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
    var readAgainBtn:UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
    
    var buttonsArray:[UIView] = []
    
    func initWithView(_baseView:UIView){
        
        baseView = _baseView
        
        initDrawBtn()
        initBackBtn()
        initUndoBtn()
        initStartOverBtn()
        initSaveBtn()
        initHonorBtn()
        initReadAgainBtn()
        
    }
    
    //MARK: Buttons
    
    //utility method that all the button initializers use, rather than repeat the same code over and over with each button
    func initBtn(button:UIButton, withImage image:UIImage, atX x:CGFloat, atY y:CGFloat, withSelector selector:Selector){
        
        button.frame = CGRectMake(x, y, image.size.width * 2, image.size.height * 2)
        
        button.setImage(image, forState: .Normal)
        
        button.addTarget(self, action: selector, forControlEvents: UIControlEvents.TouchUpInside)
        
        baseView.addSubview(button)
        
        buttonsArray.append(button)
    }
    
    //MARK: Draw Button
    func initDrawBtn(){
        baseView.addSubview(drawBtn.view)
        drawBtn.view.hidden = true
        buttonsArray.append(drawBtn.view)
        //note: tap is programmed inside the drawingButton class
    }

    
    //MARK: Back Button
    func initBackBtn(){
        
        let backImg = UIImage(named: "back_red")
        var x:CGFloat = 10
        var y:CGFloat = Global.sharedInstance.screenHeight * 0.01
        
        backBtn.hidden = true
        initBtn(backBtn, withImage:backImg!, atX: x, atY: y, withSelector: "tapBackBtn:")
        
    }
    
    func tapBackBtn(sender: UIButton!) {
        NSNotificationCenter.defaultCenter().postNotificationName("tapBackButton", object: self)
    }
    
    //MARK: Undo Button
    func initUndoBtn(){
        
        let undoImg = UIImage(named: "undo_red")
        var x:CGFloat = Global.sharedInstance.screenWidth - (undoImg!.size.width*2) - 13
        var y:CGFloat = Global.sharedInstance.screenHeight * 0.0275
        
        undoBtn.hidden = true
        initBtn(undoBtn, withImage:undoImg!, atX: x, atY: y, withSelector: "tapUndoBtn:")
        
    }
    
    func tapUndoBtn(sender: UIButton!) {
        NSNotificationCenter.defaultCenter().postNotificationName("tapUndoButton", object: self)
    }
    
    
    //MARK: Start Over Button
    func initStartOverBtn(){
        
        let startOverRedImg = UIImage(named: "start_over_red")
        var x:CGFloat = Global.sharedInstance.screenWidth - (startOverRedImg!.size.width*2) - 13
        var y:CGFloat = Global.sharedInstance.screenHeight * 0.15
        startOverBtn.hidden = true
        initBtn(startOverBtn, withImage:startOverRedImg!, atX: x, atY: y, withSelector: "tapStartOverBtn:")
        
    }
    
    func tapStartOverBtn(sender: UIButton!) {
        NSNotificationCenter.defaultCenter().postNotificationName("tapStartOverButton", object: self)
    }
    
    //MARK: Save Button
    func initSaveBtn(){
        
        let saveImg = UIImage(named: "save_red")
        var x:CGFloat = Global.sharedInstance.screenWidth - (saveImg!.size.width*2) - 13
        var y:CGFloat = Global.sharedInstance.screenHeight * 0.315
        saveBtn.hidden = true
        initBtn(saveBtn, withImage:saveImg!, atX: x, atY: y, withSelector: "tapSaveBtn:")
        
    }
    
    func tapSaveBtn(sender: UIButton!) {
        NSNotificationCenter.defaultCenter().postNotificationName("tapSaveButton", object: self)
    }
    
    //MARK: Honor Button
    func initHonorBtn(){
        
        let honorImg = UIImage(named: "honor_red")
        var x:CGFloat = (Global.sharedInstance.screenWidth/2) - (honorImg!.size.width)
        var y:CGFloat = Global.sharedInstance.screenHeight * 0.8 - (honorImg!.size.height)
        honorBtn.hidden = true
        initBtn(honorBtn, withImage:honorImg!, atX: x, atY: y, withSelector: "tapHonorBtn:")
        
    }
    
    func tapHonorBtn(sender: UIButton!) {
        NSNotificationCenter.defaultCenter().postNotificationName("tapHonorButton", object: self)
    }
    
    //MARK: read again
    func initReadAgainBtn(){
        
        let readAgainImg = UIImage(named: "read_again_white")
        var x:CGFloat = (Global.sharedInstance.screenWidth/2) - (readAgainImg!.size.width)
        var y:CGFloat = Global.sharedInstance.screenHeight * 0.825 - (readAgainImg!.size.height)
        readAgainBtn.hidden = true
        initBtn(readAgainBtn, withImage:readAgainImg!, atX: x, atY: y, withSelector: "tapReadAgainBtn:")
        
    }
    
    func tapReadAgainBtn(sender: UIButton!) {
        NSNotificationCenter.defaultCenter().postNotificationName("tapResetButton", object: self)
    }
    
    //MARK: z-index
    
    //moves all the buttons to the top of the pile
    //this is used as the text and drawing controllers are being added and removed (for improved CPU performance)
    //and the buttons need to stay on top of those other views in order to be tap accessible at all times
    
    func moveToTop(){
        
        for button in buttonsArray {
            button.removeFromSuperview()
            baseView.addSubview(button)
        }
    }
    
}
