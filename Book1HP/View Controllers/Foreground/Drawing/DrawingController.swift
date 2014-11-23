//
//  DrawController.swift
//  Book1HP
//
//  Created by Jason Snell on 6/10/14.
//  Copyright (c) 2014 HKI. All rights reserved.
//

import UIKit

class DrawingController: UIViewController, UIGestureRecognizerDelegate {
    
    var parentView:UIView = UIView()
    
    let palette:DrawingPalette = DrawingPalette()
    
    //BRUSH CONSTANTS
    
    // 1.0 is highest/finest resolution, but slowest performance.
    // Increase number to get less fine ressolution and better processing speed
    var RESOLUTION:CGFloat = 2.0
    
    
    //IMAGES & VIEWS
    //canvas the image is drawn into
    var canvasImageView:UIImageView = UIImageView()
    
    //image used to brush texture
    var brushImageTexture:UIImage = UIImage()
    
    //BRUSH ACTION
    //recognizes swipes much better than touchesMoved method
    var panRecognizer:UIPanGestureRecognizer = UIPanGestureRecognizer()
    
    //for tracking brush strokes / swipes in pan gesture
    var lastPoint:CGPoint = CGPoint()
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        //create root view
        self.view = UIView(frame: CGRectMake(0, 0, Global.sharedInstance.screenWidth, Global.sharedInstance.screenHeight));
        
        //init palette and it's bg
        palette.initWithView(self.view)
        palette.addBackground()
        
        //init and add canvas
        canvasImageView = UIImageView(image:UIImage())
        canvasImageView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        self.view.addSubview(canvasImageView)
        
        //add palette tools (on top of canvas image)
        palette.addTools()
      
        //init brush
        refreshBrush()
        
        //set up gesture and sub controller listeners
        setUpListeners()
        
    }
    
    
    
    //MARK: touch inputs
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent){
        
        //get location of touch
        var touch:UITouch = touches.anyObject() as UITouch
        
        //record last point 
        lastPoint = touch.locationInView(self.view)
        
        //adjust point to have brush appear in middle of touch point rather than top left corner
        lastPoint.x -= brushImageTexture.size.width/2
        lastPoint.y -= brushImageTexture.size.height/2
        
        //draw brush at point
        drawAtPoint(lastPoint)
    }

    func move(sender: UIPanGestureRecognizer) {
        
        //get touch contact point from gesture recognizier
        var currentPoint:CGPoint = sender.locationInView(self.view)
        
        //adjust point to center brush image
        currentPoint.x -= brushImageTexture.size.width/2
        currentPoint.y -= brushImageTexture.size.height/2
        
        //draw brush at point
        drawAtPoint(currentPoint)
        
        //when the gesture has ended, save the image to the undo array
        if (sender.state == UIGestureRecognizerState.Ended){
            GraphicsData.sharedInstance.saveCurrentState(canvasImageView.image!)
        }
        
    }
    
    //MARK: rendering
    func drawAtPoint(point:CGPoint){
        
        //start cg context
        UIGraphicsBeginImageContext(self.view.frame.size);
        
        //draw into image rect
        canvasImageView.image?.drawInRect(CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height))
        
        var vector:CGPoint = CGPointMake(CGFloat(point.x - lastPoint.x), CGFloat(point.y - lastPoint.y));
        
        
        var distance:CGFloat = CGFloat(hypotf(Float(vector.x), Float(vector.y)));
        //var distance:CGFloat = hypotf(vector.x, vector.y);
        vector.x /= distance;
        vector.y /= distance;
        
        /*
        //error - causes dots to be draw in line
        //if just a tap, put a splotch on canvas
        if (distance == 0){
            brushImageTexture.drawAtPoint(point, blendMode: blendMode, alpha: BRUSH_DENSITY * 2)
        }
        */
        
        //create a stroke
        for (var i:CGFloat = 0; i < distance; i += RESOLUTION) {
            var p:CGPoint = CGPointMake(lastPoint.x + i * vector.x, lastPoint.y + i * vector.y);
            brushImageTexture.drawAtPoint(p, blendMode: palette.brushes.blendMode, alpha: palette.brushes.brushDensity)
        }
        
        CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), true) //smoothing?
        CGContextSetShouldAntialias(UIGraphicsGetCurrentContext(), true)
        
        //move cg info into image
        canvasImageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        //end cg context
        UIGraphicsEndImageContext();
        
        //update point
        lastPoint = point;
        
    }
    
    //tint
    func tintImage(image:UIImage, withColor color:UIColor) -> UIImage{
        
        UIGraphicsBeginImageContext(image.size);
        
        CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0, image.size.height);
        CGContextScaleCTM(UIGraphicsGetCurrentContext(), 1.0, -1.0);
        
        var rect:CGRect = CGRectMake(0, 0, image.size.width, image.size.height);
        
        // draw alpha-mask
        CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeNormal);
        CGContextDrawImage(UIGraphicsGetCurrentContext(), rect, image.CGImage);
        
        // draw tint color, preserving alpha values of original image
        CGContextSetBlendMode(UIGraphicsGetCurrentContext(), kCGBlendModeSourceIn)
        color.setFill()
        CGContextFillRect(UIGraphicsGetCurrentContext(), rect);
        
        var coloredImage:UIImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return coloredImage;
        
        
    }
    
    //MARK: canvas management
    
    //wipe away all graphics from canvas and saved state
    func clearCanvas(){
        canvasImageView.image = UIImage()
        GraphicsData.sharedInstance.removeArtworkAtID(Global.sharedInstance.currPage)
    }
    
    //revert canvas to prior state. Repeatable until canvas is clear
    func undoCanvas(){
        canvasImageView.image = GraphicsData.sharedInstance.getPreviousState()
    }
    
    //saves image to photo gallery
    func saveCanvas(){
        
        //save current image
        GraphicsData.sharedInstance.saveArtwork(canvasImageView.image!, withID: Global.sharedInstance.currPage)
        
        //if any mark has been made, save the image to the photos gallery
        if (GraphicsData.sharedInstance.undoStates.count > 0){
            UIImageWriteToSavedPhotosAlbum(canvasImageView.image,
                self,
                "image:didFinishSavingWithError:contextInfo:",
                nil)

        }
    }
    
    func closeCanvas(){
        //save current image
        GraphicsData.sharedInstance.saveArtwork(canvasImageView.image!, withID: Global.sharedInstance.currPage)
        
        //clear undo states
        GraphicsData.sharedInstance.removeUndoStates()
        
        
    }
    
    func image(image:UIImage, didFinishSavingWithError error:NSError?, contextInfo: UnsafePointer<()>){
      
        if (error == nil){
            PopupManager.sharedInstance.imageSaveComplete()
        } else {
            PopupManager.sharedInstance.imageSaveError()
        }

    }
   
    
    //MARK: listeners
    func setUpListeners(){
        
        //pan recognizer for strokes
        panRecognizer = UIPanGestureRecognizer(
            target:self,
            action:Selector("move:"))
        panRecognizer.minimumNumberOfTouches = 1
        view.addGestureRecognizer(panRecognizer)
        
        //brush selected in palette
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "refreshBrush",
            name: "brushSelected",
            object: nil)
        
        //color selected in palette
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "refreshBrush",
            name: "colorSelected",
            object: nil)
        
        //start over button pressed
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "clearCanvas",
            name: "tapStartOverButton",
            object: nil)
        
        //undo button pressed
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "undoCanvas",
            name: "tapUndoButton",
            object: nil)
        
        //undo button pressed
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "saveCanvas",
            name: "tapSaveButton",
            object: nil)
    }
    
    func refreshBrush(){
        brushImageTexture = tintImage(palette.brushes.selectedBrush, withColor: palette.colors.selectedColor)
    }

    
    //MARK: show / hide
    
    func show(){
        
        //hide alpha
        self.view.alpha = 0
        
        //add to parent
        parentView.addSubview(self.view)
        
        //has art been created for this page?
        var artID:Int = Global.sharedInstance.currPage
        
        if (GraphicsData.sharedInstance.isThereArtworkWithID(artID)){
            
            //if so, then load that artwork
            canvasImageView.image = GraphicsData.sharedInstance.getArtworkWithID(artID)
            
            //and save this images as the first undo state
            GraphicsData.sharedInstance.saveCurrentState(canvasImageView.image!)
            
        } else {
            
            //if not, then init as blank
            canvasImageView.image = UIImage()
        }

        //fade in
        UIView.animateWithDuration(Global.sharedInstance.FADEIN,
            delay: 0.0,
            options:UIViewAnimationOptions.CurveEaseInOut,
            animations: {
                self.view.alpha = 1
            }, completion: {(value: Bool) in
                
            }
        )
    }
    
    func hide(){
        
        UIView.animateWithDuration(Global.sharedInstance.FADEOUT,
            delay: 0.0,
            options:UIViewAnimationOptions.CurveEaseInOut,
            animations: {
                self.view.alpha = 0
            }, completion: {(value: Bool) in
                
                self.canvasImageView.image = nil
                self.view.removeFromSuperview()
                
            }
        )
    }

    
    
}
