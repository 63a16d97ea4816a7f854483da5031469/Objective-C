//
//  NewcomerGuide.swift
//  NewcomerGuide
//
//  Created by 冯成林 on 16/7/14.
//  Copyright © 2016年 冯成林. All rights reserved.
//

import UIKit

class NewcomerGuide: UIImageView {
    
    override init(frame: CGRect) {super.init(frame: frame); viewprepare()}
    
    required init?(coder aDecoder: NSCoder) {super.init(coder: aDecoder); viewprepare()}
    
    func viewprepare(){
        frame = UIScreen.mainScreen().bounds
        userInteractionEnabled = true
    }
    
    var currentNum: Int = 0
    
    lazy var imgs: [String] = {
    
        let isIPhone4 = UIScreen.mainScreen().bounds.size.height <= 480
        
        return isIPhone4 ? ["i_4_0","i_4_1","i_4_2","i_4_3"] : ["i_6plus_0","i_6plus_1","i_6plus_2","i_6plus_3"]
        
    }()

    func show(){
        
        let w = UIApplication.sharedApplication().keyWindow
    
        image = UIImage(named: imgs[currentNum])
        
        w?.addSubview(self)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        super.touchesEnded(touches, withEvent: event)
        
        currentNum += 1
        
        if currentNum >= imgs.count {
        
            
            UIView.animateWithDuration(0.5, animations: {
                
                self.transform = CGAffineTransformMakeScale(1.5, 1.5)
                self.alpha = 0
                
            }, completion: { b in
                
                self.image = nil
                self.removeFromSuperview()
            })
            
            return
        }
        
        show()
        
    }
    
}
