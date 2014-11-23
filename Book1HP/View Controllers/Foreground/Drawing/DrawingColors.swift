//
//  DrawingColors.swift
//  Book1HP
//
//  Created by Jason Snell on 7/8/14.
//  Copyright (c) 2014 HKI. All rights reserved.
//

import UIKit

class DrawingColors:NSObject {
    
    //color constants
    var COLOR_RED:UIColor = UIColor(red: 204/255, green: 61/255, blue: 2/255, alpha: 1.0)
    var COLOR_YELLOW:UIColor = UIColor(red: 218/255, green: 158/255, blue: 0/255, alpha: 1.0)
    var COLOR_BLUE:UIColor = UIColor(red: 60/255, green: 97/255, blue: 93/255, alpha: 1.0)
    var COLOR_GREEN:UIColor = UIColor(red: 118/255, green: 127/255, blue: 56/255, alpha: 1.0)
    var COLOR_PURPLE:UIColor = UIColor(red: 146/255, green: 102/255, blue: 114/255, alpha: 1.0)
    var COLOR_BROWN:UIColor = UIColor(red: 140/255, green: 93/255, blue: 36/255, alpha: 1.0)
    var COLOR_WHITE:UIColor = UIColor(red: 230/255, green: 224/255, blue: 206/255, alpha: 1.0)
    var COLOR_GREY:UIColor = UIColor(red: 158/255, green: 146/255, blue: 127/255, alpha: 1.0)
    var COLOR_BLACK:UIColor = UIColor(red: 15/255, green: 15/255, blue: 15/255, alpha: 1.0)
    
    //interface buttons
    var redBtn:UIButton = UIButton()
    var yellowBtn:UIButton = UIButton()
    var blueBtn:UIButton = UIButton()
    var greenBtn:UIButton = UIButton()
    var purpleBtn:UIButton = UIButton()
    var brownBtn:UIButton = UIButton()
    var whiteBtn:UIButton = UIButton()
    var greyBtn:UIButton = UIButton()
    var blackBtn:UIButton = UIButton()
    
    var selectedColor:UIColor = UIColor()
    
    override init(){
        selectedColor = COLOR_BLUE
    }
    
    //MARK:taps
    func tapColorBtn(sender: UIButton) {
        
        func deselectAll(){
            redBtn.selected = false
            yellowBtn.selected = false
            blueBtn.selected = false
            greenBtn.selected = false
            purpleBtn.selected = false
            brownBtn.selected = false
            whiteBtn.selected = false
            greyBtn.selected = false
            blackBtn.selected = false
        }
        
        deselectAll()
        sender.selected = true
        
        switch(String(sender.titleLabel?.text ?? "")) {
            
        case "red":
            selectedColor = COLOR_RED
            break
            
        case "yellow":
            selectedColor = COLOR_YELLOW
            break
        
        case "blue":
            selectedColor = COLOR_BLUE
            break
            
        case "green":
            selectedColor = COLOR_GREEN
            break
            
        case "purple":
            selectedColor = COLOR_PURPLE
            break
            
        case "brown":
            selectedColor = COLOR_BROWN
            break
            
        case "white":
            selectedColor = COLOR_WHITE
            break
            
        case "grey":
            selectedColor = COLOR_GREY
            break
            
        case "black":
            selectedColor = COLOR_BLACK
            break
            
        default:
            println("Colors: no color selected")
            break
        }
        
      
        NSNotificationCenter.defaultCenter().postNotificationName("colorSelected", object: nil)
        
    }
    
    func addColorsToPalette(paletteView:UIImageView){
        
        //nested function to build uibutton
        func initColorBtn(btn:UIButton, withID id:String, atX x:CGFloat, atY y:CGFloat){
            
            //brush
            let img:UIImage = UIImage(named:"draw_color_over")!
            btn.setTitle(id, forState: .Normal)
            btn.titleLabel!.removeFromSuperview()
            btn.frame = CGRectMake(
                x,
                y,
                img.size.width, img.size.height)
            
            btn.setImage(img, forState: .Highlighted)
            btn.setImage(img, forState: .Selected)
            //btn.setImage(img, forState: .Normal)
            
            btn.addTarget(self,
                action: "tapColorBtn:",
                forControlEvents: UIControlEvents.TouchUpInside)
            
            paletteView.addSubview(btn)
            
        }
        
        let bottomY:CGFloat = 73
        let topY:CGFloat = 26.5
        
        //run each brush through build
        
        redBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        initColorBtn(redBtn,
            withID: "red",
            atX: 332,
            atY: bottomY
        )
        
        yellowBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        initColorBtn(yellowBtn,
            withID: "yellow",
            atX: 384,
            atY: bottomY
        )
        
        blueBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        initColorBtn(blueBtn,
            withID: "blue",
            atX: 436,
            atY: bottomY
        )
        
        greenBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        initColorBtn(greenBtn,
            withID: "green",
            atX: 488,
            atY: bottomY
        )
        
        purpleBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        initColorBtn(purpleBtn,
            withID: "purple",
            atX: 540,
            atY: bottomY
        )
        
        blackBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        initColorBtn(blackBtn,
            withID: "black",
            atX: 359,
            atY: topY
        )
        
        greyBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        initColorBtn(greyBtn,
            withID: "grey",
            atX: 412,
            atY: topY
        )
        
        whiteBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        initColorBtn(whiteBtn,
            withID: "white",
            atX: 464,
            atY: topY
        )
        
        brownBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        initColorBtn(brownBtn,
            withID: "brown",
            atX: 516,
            atY: topY
        )
        
        //set selected
        blueBtn.selected = true

    }
}