//
//  UIButton+SushiKit.swift
//  SushiKit
//
//  Created by Kenta Tokumoto on 2015/07/04.
//  Copyright (c) 2015年 Kenta Tokumoto. All rights reserved.
//

import Foundation
import UIKit

private var kObjectKeyForButtonColor = 0

private class ButtonColorManager {
    private var normalColor:UIColor?
    private var highlightedColor:UIColor?
    convenience init(normalColor:UIColor?, highlightedColor:UIColor?){
        self.init()
        self.normalColor = normalColor
        self.highlightedColor = highlightedColor
    }
}

public extension UIButton {

    private var buttonColor:ButtonColorManager?{
        get {
            return objc_getAssociatedObject(self, &kObjectKeyForButtonColor) as? ButtonColorManager
        }
        set {
            if let unoptionalValue = newValue {
                objc_setAssociatedObject(self, &kObjectKeyForButtonColor, unoptionalValue, UInt(OBJC_ASSOCIATION_RETAIN))
            }
        }
    }

    public override func addTarget(target: AnyObject?, action: Selector, forControlEvents controlEvents: UIControlEvents) {
        super.addTarget(target, action: action, forControlEvents: controlEvents)
        if let unwrappedTarget:AnyObject = target
            where controlEvents == .TouchUpInside {
            //Add recognizer to detect long press
            let longPressGestureRecognizer = UILongPressGestureRecognizer(target: unwrappedTarget, action: action)
            self.addGestureRecognizer(longPressGestureRecognizer)
        }
    }

    public func setBackgroundColor(#color:UIColor?, forState state:UIControlState){
        switch state {
        case UIControlState.Normal:
            self.backgroundColor = color
        case UIControlState.Highlighted:
            registerHighlightedColor(color)
        default:
            break
        }
    }

    private func registerHighlightedColor(color:UIColor?){
        self.buttonColor = ButtonColorManager(normalColor: self.backgroundColor, highlightedColor: color)
        self.addTarget(self, action: "didTouchDown:", forControlEvents: .TouchDown)
        self.addTarget(self, action: "didTouchUp:", forControlEvents: .TouchUpInside)
        self.addTarget(self, action: "didTouchUp:", forControlEvents: .TouchUpOutside)
    }

    internal func didTouchDown(button:UIButton){
        self.backgroundColor = self.buttonColor?.highlightedColor
    }

    internal func didTouchUp(button:UIButton){
        self.backgroundColor = self.buttonColor?.normalColor
    }
}