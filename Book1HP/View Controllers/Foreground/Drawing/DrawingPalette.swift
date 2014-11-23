//
//  DrawingPalette.swift
//  Book1HP
//
//  Created by Jason Snell on 7/7/14.
//  Copyright (c) 2014 HKI. All rights reserved.
//

import UIKit

class DrawingPalette:NSObject {
    
    //base view to attach graphics to
    var baseView:UIView = UIView()
    
    //background graphics
    var paletteView:UIImageView = UIImageView()
    var dottedRectView:UIImageView = UIImageView()
    
    let brushes:DrawingBrushes = DrawingBrushes()
    let colors:DrawingColors = DrawingColors()
    
    func initWithView(_baseView:UIView){
        baseView = _baseView
    }
    
    //MARK: background
    func addBackground(){
        
        //dotted rect
        let dottedRectImg:UIImage = UIImage(named:"draw_rect_red")!
        dottedRectView = UIImageView(image: dottedRectImg)
        dottedRectView.frame = CGRectMake(
            ((Global.sharedInstance.screenWidth / 2) - (dottedRectView.frame.width / 2)),
            ((Global.sharedInstance.screenHeight / 2) - (dottedRectView.frame.height / 2)),
            dottedRectView.frame.width,
            dottedRectView.frame.height)
        baseView.addSubview(dottedRectView)
        
    }

    //MARK: tools
    func addTools(){
        
        //tools
        let paletteImg:UIImage = UIImage(named:"tools")!
        paletteView = UIImageView(image: paletteImg)
        paletteView.userInteractionEnabled = true
        paletteView.frame = CGRectMake(
            ((Global.sharedInstance.screenWidth / 2) - (paletteView.frame.width / 2)),
            ((Global.sharedInstance.screenHeight) - (paletteView.frame.height)),
            paletteView.frame.width,
            paletteView.frame.height)
        baseView.addSubview(paletteView)
        
        //add brushes
        brushes.addBrushesToPalette(paletteView)
        colors.addColorsToPalette(paletteView)
    }

}
