//
//  ApplicationState.swift
//  Book1HP
//
//  Created by Jason Snell on 7/2/14.
//  Copyright (c) 2014 HKI. All rights reserved.
//

import Foundation

let ApplicationStateSharedInstance = ApplicationState();

class ApplicationState {
    
    var currentState:Int = 0
    
    let STATE_INTRO:Int = 0
    let STATE_INSTRUCTIONS:Int = 1
    let STATE_PROLOG:Int = 2
    let STATE_PROLOG_LAST_PAGE:Int = 3
    let STATE_TITLE:Int = 4
    let STATE_STORY_FIRST_PAGE:Int = 5
    let STATE_STORY:Int = 6
    let STATE_DRAW:Int = 7
    let STATE_STORY_LAST_PAGE:Int = 8
    let STATE_END:Int = 9
    
    /*
    Sequence
    intro anim, starts automatically on launch. swipe inactive
    swipe instructions - swipe to move on
    prolog - normal text swipes, no draw btn
    prolog last page - last text, swipe brings in scroll/title anim, not another text
    title - swipe inactive - automatically resolves to story page 1 (fade in)
    story - normal text swipes w draw btn
    draw - draw state, no swipes
    story last page -
    end - swipes inactive. replay button starts over
    */
    
    class var sharedInstance:ApplicationState {
        return ApplicationStateSharedInstance;
    }
    
    init(){
        
    }
    
}
