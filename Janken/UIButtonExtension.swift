//
//  UIButtonExtension.swift
//  Janken
//
//  Created by Ryan Kanno on 4/28/20.
//  Copyright © 2020 Ryan Kanno. All rights reserved.
//

import UIKit

extension UIButton {
    
    func pulsate() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.3
        pulse.fromValue = 1
        pulse.toValue = 1.3
        pulse.autoreverses = true
        pulse.repeatCount = 0
        pulse.initialVelocity = 0.6
        pulse.damping = 1
        
        layer.add(pulse, forKey: nil)
        
     }
    
}

extension UIImageView {
    
    func pulsate() {
       
       let pulse = CASpringAnimation(keyPath: "transform.scale")
       pulse.duration = 0.3
       pulse.fromValue = 1
       pulse.toValue = 1.3
       pulse.autoreverses = true
       pulse.repeatCount = 0
       pulse.initialVelocity = 0.6
       pulse.damping = 1
       
       layer.add(pulse, forKey: nil)
       
    }
    
}

