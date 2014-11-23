//
//  DrawingBrushes.swift
//  Book1HP
//
//  Created by Jason Snell on 7/7/14.
//  Copyright (c) 2014 HKI. All rights reserved.
//

import UIKit

class DrawingBrushes:NSObject {
    
    //brush constants
    
    var BRUSH_PENCIL:UIImage = UIImage(named:"brush_pencil")!
    var BRUSH_CRAYON:UIImage = UIImage(named:"brush_marker")!
    var BRUSH_MARKER:UIImage = UIImage(named:"brush_angle")!
    var BRUSH_BRUSH:UIImage = UIImage(named:"brush_mottle_angle")!
    var BRUSH_WAND:UIImage = UIImage(named:"brush_gradient")!
    var BRUSH_ERASER:UIImage = UIImage(named:"brush_marker")!
    
    
    //interface buttons
    var pencilBtn:UIButton = UIButton()
    var crayonBtn:UIButton = UIButton()
    var markerBtn:UIButton = UIButton()
    var brushBtn:UIButton = UIButton()
    var wandBtn:UIButton = UIButton()
    var eraserBtn:UIButton = UIButton()
    
    var selectedBrush:UIImage = UIImage()
    
    // 1.0 is max density
    var brushDensity:CGFloat = 0.2
    var blendMode:CGBlendMode = kCGBlendModeNormal
    
    
    
    override init(){
        selectedBrush = BRUSH_MARKER
        brushDensity = 0.3
        blendMode = kCGBlendModeNormal
    }
    
    //MARK:taps
    func tapBrushBtn(sender: UIButton) {
        
        func deselectAll(){
            pencilBtn.selected = false
            crayonBtn.selected = false
            markerBtn.selected = false
            brushBtn.selected = false
            wandBtn.selected = false
            eraserBtn.selected = false
        }
        
        deselectAll()
        sender.selected = true
        
        if let label = sender.titleLabel {
        
            switch(String(label.text!)) {
            
            case "pencil":
                selectedBrush = BRUSH_PENCIL
                brushDensity = 0.2
                blendMode = kCGBlendModeNormal
                break
            
            case "crayon":
                selectedBrush = BRUSH_CRAYON
                brushDensity = 0.1
                blendMode = kCGBlendModeNormal
                break
            
            case "marker":
                selectedBrush = BRUSH_MARKER
                brushDensity = 0.3
                blendMode = kCGBlendModeNormal
                break
            
            case "brush":
                selectedBrush = BRUSH_BRUSH
                brushDensity = 0.2
                blendMode = kCGBlendModeNormal
                break
            
            case "wand":
                selectedBrush = BRUSH_WAND
                brushDensity = 0.05
                blendMode = kCGBlendModeLighten
                break
            
            case "eraser":
                selectedBrush = BRUSH_ERASER
                brushDensity = 0.1
                blendMode = kCGBlendModeClear
                break
            
            default:
                println("Brushes: no brush selected")
                break
            }
            
        }

        
        NSNotificationCenter.defaultCenter().postNotificationName("brushSelected", object: nil)
        
    }
    
    func addBrushesToPalette(paletteView:UIImageView){
        
        //nested function to build uibutton
        func initBrushBtn(btn:UIButton, withID id:String, atX x:CGFloat){
            
            //brush
            let img:UIImage = UIImage(named:"draw_" + id + "_over")!
            btn.setTitle(id, forState: .Normal)
            btn.titleLabel?.removeFromSuperview()
            btn.frame = CGRectMake(
                x,
                paletteView.frame.height - img.size.height,
                img.size.width, img.size.height)
            
            btn.setImage(img, forState: .Highlighted)
            btn.setImage(img, forState: .Selected)
            //btn.setImage(img, forState: .Normal)
            
            btn.addTarget(self,
                action: "tapBrushBtn:",
                forControlEvents: UIControlEvents.TouchUpInside)
            
            paletteView.addSubview(btn)
            
        }
        

        //run each brush through build
        pencilBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        initBrushBtn(pencilBtn,
            withID: "pencil",
            atX: 41
        )
        
        crayonBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        initBrushBtn(crayonBtn,
            withID: "crayon",
            atX: 92
        )
        
        markerBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        initBrushBtn(markerBtn,
            withID: "marker",
            atX: 145
        )
        
        brushBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        initBrushBtn(brushBtn,
            withID: "brush",
            atX: 209
        )
    
        wandBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        initBrushBtn(wandBtn,
            withID: "wand",
            atX: 255
        )
        
        eraserBtn = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        initBrushBtn(eraserBtn,
            withID: "eraser",
            atX: 608
        )
        
        markerBtn.selected = true

    }

    
}
