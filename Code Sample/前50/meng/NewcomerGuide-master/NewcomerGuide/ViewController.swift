//
//  ViewController.swift
//  NewcomerGuide
//
//  Created by 冯成林 on 16/7/14.
//  Copyright © 2016年 冯成林. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    lazy var ng: NewcomerGuide = NewcomerGuide(frame: CGRectMake(0, 0, 0, 0))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,Int64(1 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
            self.ng.show()
        })
    }

}

