//
//  TempView.swift
//  Book1HP
//
//  Created by Jason Snell on 6/30/14.
//  Copyright (c) 2014 HKI. All rights reserved.
//

import UIKit

class TempView: UIViewController {
    
    override func viewDidLoad() {
        var tempView:UIView = UIView()
        tempView.frame = CGRectMake(0,0,200,200)
        tempView.backgroundColor = UIColor.redColor()
        self.view.addSubview(tempView)
        
        let spaceImg:UIImage = UIImage(named: "space_bg.jpg")
        let spaceView:UIImageView = UIImageView(image: spaceImg)
        self.view.addSubview(spaceView)
    }
    
    
}