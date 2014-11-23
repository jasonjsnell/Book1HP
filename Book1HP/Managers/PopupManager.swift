//
//  PopupManager.swift
//  Book1HP
//
//  Created by Jason Snell on 7/9/14.
//  Copyright (c) 2014 HKI. All rights reserved.
//

import UIKit

let PopupManagerSharedInstance = PopupManager();

class PopupManager {
    
    var rootViewController:UIViewController = UIViewController()
    
    class var sharedInstance:PopupManager {
        return PopupManagerSharedInstance;
    }
    
    init(){
        
    }
    
    //MARK: image saving
    func imageSaveComplete(){
        showAlertWithTitle("Hooray!",
            withMessage: "Your artwork has been saved to your iPad's Photo Gallery.")
    }
    func imageSaveError(){
        showAlertWithTitle("Uh oh!",
            withMessage: "We had a problem saving your artwork. Please try again or take a screenshot.")
    }
    
    func showAlertWithTitle(title:String, withMessage message:String){
        
        var device : UIDevice = UIDevice.currentDevice();
        var systemVersion = device.systemVersion;
        //var iosVerion : Float = systemVersion.bridgeToObjectiveC().floatValue;
        var iosVerion : Float = (systemVersion as NSString).floatValue;
        
        if(iosVerion < 8.0) {
            
            //iOS 8
            
            println("activate alert before deployment")
            println(title)
            println(message)
            
            /*
            var alert = UIAlertController(title: title,
                message: message,
                preferredStyle: UIAlertControllerStyle.Alert)
            
            alert.addAction(UIAlertAction(title: "Ok",
                style: UIAlertActionStyle.Default,
                handler:{ (ACTION :UIAlertAction!)in
                    //
                }))
            rootViewController.presentViewController(alert, animated: true, completion: nil)
            */
            
        }else{
            
            //iOS 7 and before
            
            let alert = UIAlertView()
            alert.title = title
            alert.message = message
            alert.addButtonWithTitle("OK")
            alert.show()
        }
        
        
        
        
    }

    
    
    

    
}


