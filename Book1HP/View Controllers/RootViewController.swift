//
//  ViewController.swift
//  Book1HP
//
//  Created by Jason Snell on 6/10/14.
//  Copyright (c) 2014 HKI. All rights reserved.
//

/*

Order

-show space
-unfold scroll
-show title sequence
-begin story with drawing capabilites
-have image panels at appropriate places
-end story
-close scroll
-honor pledge
-reset button


*/

import UIKit

class RootViewController: UIViewController {
    
    let background:BackgroundController = BackgroundController()
    let foreground:ForegroundController = ForegroundController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up listeners
        setUpListeners()
        
        //add views to stage
        self.view.addSubview(background.view)
        self.view.addSubview(foreground.view)
        
        //set up popup manager
        PopupManager.sharedInstance.rootViewController = self
       
        //timed animations for AC intro
        background.showIntro()
        
        //skipIntro()
    }
    
    //testing only
    func skipIntro(){
        
        Global.sharedInstance.currPage = 2
        ApplicationState.sharedInstance.currentState = ApplicationState.sharedInstance.STATE_STORY
        titleToStory()
        background._scroll.show()
    }
    
    //MARK: forward progress state changes, in order of occurrence
    
    func introToInstructions(){
        foreground.showInstructions()
        ApplicationState.sharedInstance.currentState = ApplicationState.sharedInstance.STATE_INSTRUCTIONS
    }
    
    func instructionsToProlog(){
        //remove instructions label, text comes in from left side
        ApplicationState.sharedInstance.currentState = ApplicationState.sharedInstance.STATE_PROLOG
        foreground.hideInstructions()
        foreground.textController.show()
        foreground.textController.enterFromRight()
    }
    
    func prologToTitle(){
        //exit text, and open up scroll
        ApplicationState.sharedInstance.currentState = ApplicationState.sharedInstance.STATE_TITLE
        foreground.textController.exitToLeft()
        background.openScroll()
    }
    
    func titleToStory(){
        ApplicationState.sharedInstance.currentState = ApplicationState.sharedInstance.STATE_STORY_FIRST_PAGE
        //advance to next page, and past "STORY" marker in text data
        Global.sharedInstance.currPage += 2
        //text in from right
        foreground.textController.fadeInCenter()
        //load interface
        foreground.showStoryInterface()
    }
    
    func storyToOutro(){
        //exit text, and close up scroll
        ApplicationState.sharedInstance.currentState = ApplicationState.sharedInstance.STATE_END
        Global.sharedInstance.bg = Global.sharedInstance.SPACE
        foreground.textController.exitToLeft()
        foreground.hideStoryInterface()
        foreground.hideStoryLastPage()
        background.closeScroll()
    }
    
    func showEnd(){
        foreground.textController.showHonorPledge()
        foreground.showEnd()
    }
    
    func resetBook(){
        ApplicationState.sharedInstance.currentState = ApplicationState.sharedInstance.STATE_PROLOG
        Global.sharedInstance.currPage = 0
        background.reset()
        foreground.hideEnd()
        foreground.textController.show()
        foreground.textController.enterFromRight()
    }
    
    //MARK: reverse progress state changes
    func storyLastPageToStoryBody(){
        //normal text swipe
        //move story back to story body
        ApplicationState.sharedInstance.currentState = ApplicationState.sharedInstance.STATE_STORY
        foreground.textController.slideToRight()
        foreground.hideStoryLastPage()
        foreground.showStoryInterface()
    }
    

    //MARK: Swipes
    func processSwipeLeftGesture(){
        
        switch(ApplicationState.sharedInstance.currentState) {
        
        case ApplicationState.sharedInstance.STATE_STORY:
            //normal text swipe
            foreground.textController.slideToLeft()
            
            //check for next page to show last page interface on swipe
            var nextText:String = TextData.sharedInstance.getPageByID(Global.sharedInstance.currPage + 1)
            if (nextText == "EPILOG"){ foreground.showStoryLastPage() }

            break;
            
        case ApplicationState.sharedInstance.STATE_PROLOG:
            //normal text swipe
            foreground.textController.slideToLeft()
            break;
            
        case ApplicationState.sharedInstance.STATE_STORY_FIRST_PAGE:
            //normal text swipe, move from first page to main body of story
            ApplicationState.sharedInstance.currentState = ApplicationState.sharedInstance.STATE_STORY
            foreground.textController.slideToLeft()
            break;
            
        case ApplicationState.sharedInstance.STATE_STORY_LAST_PAGE:
            storyToOutro()
            break;
            
        case ApplicationState.sharedInstance.STATE_PROLOG_LAST_PAGE:
            prologToTitle()
            break;
            
        case ApplicationState.sharedInstance.STATE_INSTRUCTIONS:
            instructionsToProlog()
            break;
            
        default:
            //intro, draw, end, title states - do nothing
            println("SWIPE: intro, draw, end, title states - do nothing")
            break;
        }
        
    }
    
    func processSwipeRightGesture(){
        
        switch(ApplicationState.sharedInstance.currentState) {
            
        case ApplicationState.sharedInstance.STATE_STORY:
            //normal text swipe in story body
            foreground.textController.slideToRight()
            break;
            
        case ApplicationState.sharedInstance.STATE_STORY_LAST_PAGE:
            storyLastPageToStoryBody()
            break;
            
        default:
            //anywhere else - do nothing
            println("SWIPE: only in story body")
            break;
            
        }

    }
    
    func swipeTextComplete(){
        
        //check the next page in the text data for markers that indicate a change in the story
        //for example, moving from prolog to story, or story to epilog
        //this changes the application state so the next swipe can be handled correctly
        
        var nextPageText:String = TextData.sharedInstance.getPageByID(Global.sharedInstance.currPage + 1)
        
        if (nextPageText == "STORY"){
            ApplicationState.sharedInstance.currentState = ApplicationState.sharedInstance.STATE_PROLOG_LAST_PAGE
        } else if (nextPageText == "EPILOG"){
            ApplicationState.sharedInstance.currentState = ApplicationState.sharedInstance.STATE_STORY_LAST_PAGE
        }
        
        var prevPageID:Int = Global.sharedInstance.currPage - 1
        if (prevPageID > 0){
            var prevPageText:String = TextData.sharedInstance.getPageByID(prevPageID)
            if (prevPageText == "STORY"){
                ApplicationState.sharedInstance.currentState = ApplicationState.sharedInstance.STATE_STORY_FIRST_PAGE
            }
        }
        
        //also check if there is a current image already drawn for this page of the story
        
        if (ApplicationState.sharedInstance.currentState == ApplicationState.sharedInstance.STATE_STORY ||
            ApplicationState.sharedInstance.currentState == ApplicationState.sharedInstance.STATE_STORY_FIRST_PAGE) {
                
                NSNotificationCenter.defaultCenter().postNotificationName("drawingButtonWillAppear", object: self)
                
        }

        
    }
    
    //MARK: listeners
    func setUpListeners(){
        
        //when screen is swiped left
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "processSwipeLeftGesture",
            name: "swipeLeftGesture",
            object: nil)
        
        //swipe right
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "processSwipeRightGesture",
            name: "swipeRightGesture",
            object: nil)
        
        //text is done swiping / animating to center screen
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "swipeTextComplete",
            name: "swipeTextComplete",
            object: nil)
        
        //when drawing button is appearing
        //a check needs to happen to see if there is pre-existing user artwork for that page
        //and if so, put the artwork inside the drawing button circle
        NSNotificationCenter.defaultCenter().addObserver(foreground.buttons.drawBtn,
            selector: "checkForUserArtwork",
            name: "drawingButtonWillAppear",
            object: nil)
        
        //when animations are complete
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "introToInstructions",
            name: "introAnimComplete",
            object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "titleToStory",
            name: "titleAnimComplete",
            object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "showEnd",
            name: "scrollCloseComplete",
            object: nil)
        
        //reset button at end is tapped
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "resetBook",
            name: "tapResetButton",
            object: nil)
        
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        println("MEMORY WARNING: root view controller")
    }


}

