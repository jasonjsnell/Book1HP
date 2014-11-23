//
//  GraphicsData.swift
//  Book1HP
//
//  Created by Jason Snell on 7/8/14.
//  Copyright (c) 2014 HKI. All rights reserved.
//

import UIKit

let GraphicsDataSharedInstance = GraphicsData()

class GraphicsData {
    
    var undoStates:[UIImage] = []
    var userArtwork: [Int: UIImage] = [0: UIImage()]
    var assetDirPath:String = ""
    
    class var sharedInstance:GraphicsData {
        return GraphicsDataSharedInstance
    }
    
    init(){
        
        //init path to documents directory inside app
        let nsDocumentDirectory:NSSearchPathDirectory = NSSearchPathDirectory.DocumentDirectory
        let nsUserDomainMask:NSSearchPathDomainMask = NSSearchPathDomainMask.UserDomainMask
        if let paths:Array = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true) {
            if paths.count > 0 {
                assetDirPath = paths[0] as String
            }
        }
    }
    
    //MARK: undo states
    func saveCurrentState(image:UIImage){
        undoStates.append(image)
    }
    
    func getPreviousState()->UIImage {
        
        if (undoStates.count > 1){
            undoStates.removeLast()
            return undoStates[undoStates.count-1]
            
        } else {
            undoStates = []
            return UIImage()
        }
        
    }
    
    func removeUndoStates(){
        undoStates = []
    }
    
    //MARK: save and retrieve artwork
    //saves artwork uiimage into documents directory, named after current page num
    func saveArtwork(artwork:UIImage, withID id:Int){
        
        //if there is artwork to save, then save it
        if let pngData:NSData = UIImagePNGRepresentation(artwork) {
            let writePath:String = assetDirPath.stringByAppendingPathComponent(String(id) + ".png")
            UIImagePNGRepresentation(artwork).writeToFile(writePath, atomically: true)
        }
    
    }
    
    //checks to see if file is present in documents directory.
    //if png data is valid, then there is art
    //if not, then no art
    func isThereArtworkWithID(id:Int) -> Bool {
        
        let readPath:String = assetDirPath.stringByAppendingPathComponent(String(id) + ".png")
        
        if let pngData:NSData = NSData(contentsOfFile: readPath, options: .DataReadingMappedIfSafe, error: nil){
            return true
        } else {
            return false
        }
        
        
    }
    
    //get the artwork from the documents directory
    func getArtworkWithID(id:Int) -> UIImage {
        
        let readPath:String = assetDirPath.stringByAppendingPathComponent(String(id) + ".png")
        
        if let pngData:NSData = NSData(contentsOfFile: readPath, options: .DataReadingMappedIfSafe, error: nil){
            return UIImage(data: pngData)!
        } else {
            return UIImage()
        }
        
    }
    
    
    func removeArtworkAtID(id:Int){
      
        let filePath:String = assetDirPath.stringByAppendingPathComponent(String(id) + ".png")
        NSFileManager.defaultManager().removeItemAtPath(filePath, error: nil)
        
    }
    
       
}



