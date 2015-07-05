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
    override public var highlighted:Bool {
        get {
            return super.highlighted
        }
        set {
            self.backgroundColor = newValue ? buttonColor?.highlightedColor : buttonColor?.normalColor
            super.highlighted = newValue
        }
    }

    public func setBackgroundColor(#color:UIColor?, forState state:UIControlState){
        switch state {
        case UIControlState.Normal:
            self.backgroundColor = color
        case UIControlState.Highlighted:
            self.buttonColor = ButtonColorManager(normalColor: self.backgroundColor, highlightedColor: color)
        default:
            break
        }
    }

}