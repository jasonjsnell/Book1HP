//
//  ViewController.swift
//  Book1HP
//
//  Created by Jason Snell on 6/10/14.
//  Copyright (c) 2014 HKI. All rights reserved.
//

/*

what is the layering of the files?

* Root Controller listens to different events in its children view controllers. For example, when the Back button is pressed on the Draw Controller, it needs to send a “close” event to the root, which then can hide that view and show the Story Controller. How? Delegate methods? The Root Controller would be the delegate of many of the children.

//VIEW CONTROLLERS
* Background controller. Includes fixed space image. that can have it's own folder of view controllers. or can they have the same one? what do they do? they are SCREEN layer blend. They animate xy, scale, and fade in, out.

Includes end animation with boy and medallion. This also includes the scroll. The edges change width and anim from center to outside edges. Center has a mask which opens up with the animation edges. Anim goes both in and out.

Includes boy and maked boy, and titles. boy is OVERLAY layer blend. Masked by is normal. Both fade in and out. Titles are normal, fade in / out. Timed to fade out, or can receive tap/swipe gesture to move on (need "Get started!" button?)

* Story controller. Has text, next/prev. Has both space and scroll modes.

* Draw controller. Has both space and scroll modes (different graphics). Has tools, canvas, undo, start over, save, print, and back buttons.

//subviews
* Canvas controller. Handles touch inputs and draws on layers with stroke and color set by tool controller. Undo button undoes the last movement. Start over clears the canvas. Print and save contact the export controller.

* Tool controller. Handles tool kit for draw screen. Select and highlight tools, colors, or eraser.

* Button Controller. ifferent configs based on what other controller is being used. Advantages - all buttons are on one layer and accessible, not blocked by other layers. Layering may be tricky as draw gets overlaid on story, and story shows some of its buttons, but not all. And the draw canvas may block the story controller buttons.

* Popup controller. Handles help requests, action confirmations, and image export options.

//MANAGERS
* Audio Manager. Handles audio. Start on press listen. Fade out if user leaves page.

* Export manager. Liason between canvas image and popup window. Renders canvas previews for user to choose in popup window. Options are scroll/space background, or white background. User selects and export renders full canvas and sends it to either pritner or Photo Gallery on device.

Also handles save all / print all requests from end frame.

This also renders the  image preview that replaces the draw button in the story mode.

* User Data Manager. Stores rendered images. Accessed by draw, story, and export controllers. Is art stored when app closes?

//VARS
*GlobalVariables
mode

//COMM

Root keeps track of:
MODE, such as “space" or “scroll"
Story location / page number

Root > Background: startIntroAnim
Background: introAnimComplete > Root
Root > Story: openProlog (space mode)
Story > Draw:open (space mode)
Draw > Root: drawClose
Root > Story: reopen (at same location)
Story > Root: prologComplete
Root > Background: startTitleAnim
Background > Root: titleAnimComplete
Root > Story: openStory (scroll mode)
Story > Draw: open (scroll mode)
Draw > Export: save / save all / print / print all
Draw > Root: drawClose
Root > Story: reopen (at same location)
Story > Root: storyComplete
Root > Background: startEpilogAnim
Background > Root: epilogAnimComplete
Root > Story: openEpilog
Story > Root: restartStory

Story & Button > Audio: playAudio(id)
Story > Audio: stopAudio (on page change)

Draw > Export
Story > Export


*/

import UIKit

class RootViewController: UIViewController {
    
    let background: BackgroundController = BackgroundController();
    let text: TextController = TextController();
    let drawing: DrawingController = DrawingController();
    let interactions: InteractionController = InteractionController();
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //set up listeners
        setUpListeners()
        
        
        //add views to stage
        self.view.addSubview(background.view);
        self.view.addSubview(text.view);
        //self.view.addSubview(drawing);
        self.view.addSubview(interactions.view);        
       
        
    }
    
    func setUpListeners(){
        
        NSNotificationCenter.defaultCenter().addObserver(text,
            selector: "slideToRight",
            name: "tapLeftArrow",
            object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(text,
            selector: "slideToLeft",
            name: "tapRightArrow",
            object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(text,
            selector: "slideToRight",
            name: "swipeRight",
            object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(text,
            selector: "slideToLeft",
            name: "swipeLeft",
            object: nil)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

