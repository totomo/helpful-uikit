//
//  UIButton+SushiKit.swift
//  SushiKit
//
//  Created by Kenta Tokumoto on 2015/07/04.
//  Copyright (c) 2015年 Kenta Tokumoto. All rights reserved.
//

import Foundation
import UIKit

public extension UIButton {

    public override func addTarget(target: AnyObject?, action: Selector, forControlEvents controlEvents: UIControlEvents) {
        super.addTarget(target, action: action, forControlEvents: controlEvents)
        if let unwrappedTarget:AnyObject = target
            where controlEvents == .TouchUpInside {
            //Add recognizer to detect long press
            let longPressGestureRecognizer = UILongPressGestureRecognizer(target: unwrappedTarget, action: action)
            self.addGestureRecognizer(longPressGestureRecognizer)
        }
    }

}