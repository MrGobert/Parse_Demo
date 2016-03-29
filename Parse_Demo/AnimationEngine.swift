//
//  AnimationEngine.swift
//  Parse_Demo
//
//  Created by James Gobert on 3/25/16.
//  Copyright © 2016 EverydayDigitals. All rights reserved.
//

import UIKit
import pop

class AnimationEngine {
    
    
    class var offScreenRightPosition: CGPoint {
        return CGPointMake(UIScreen.mainScreen().bounds.width, CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    
    class var offScreenLeftPosition: CGPoint {
        return CGPointMake(-UIScreen.mainScreen().bounds.width, CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    
    class var screenCenterPosition: CGPoint {
        return CGPointMake(CGRectGetMidX(UIScreen.mainScreen().bounds), CGRectGetMidY(UIScreen.mainScreen().bounds))
    }
    
    let ANIM_DELAY: Int = 1
    
    var originalConstrants = [CGFloat]()
    var constraints: [NSLayoutConstraint]!
    
    
    init(constraints: [NSLayoutConstraint]) {
        
        for con in constraints {
            originalConstrants.append(con.constant)
            con.constant = AnimationEngine.offScreenRightPosition.x
        }
        
        self.constraints = constraints
    }
    
    func animateOnScreen(delay: Int) {
        
        //time delay
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(delay) * Double(NSEC_PER_SEC)))
        
        dispatch_after(time, dispatch_get_main_queue()) {
            
            //Animation

            
            for index in 0...self.constraints.count - 1 {
                
                let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
                moveAnim.toValue = self.originalConstrants[index]
                moveAnim.springBounciness = 12
                moveAnim.springSpeed = 12
                
                if (index > 0) {
                    moveAnim.dynamicsFriction += 10 + CGFloat(index)
                }
                
                let con = self.constraints[index]
                con.pop_addAnimation(moveAnim, forKey: "moveOnScreen")

            }
            
        }
    }
    
    class func animateToPosition(view: UIView, position: CGPoint, completion: ((POPAnimation!, Bool) -> Void)) {
        let moveAnim = POPSpringAnimation(propertyNamed: kPOPLayerPosition)
        moveAnim.toValue = NSValue(CGPoint: position)
        moveAnim.springBounciness = 10
        moveAnim.springSpeed = 8
        moveAnim.completionBlock = completion
        view.pop_addAnimation(moveAnim, forKey: "moveToPosition")
    }
    
    
    
}


