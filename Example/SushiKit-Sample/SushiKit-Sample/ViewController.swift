//
//  ViewController.swift
//  SushiKit-Sample
//
//  Created by Kenta Tokumoto on 2015/07/04.
//  Copyright (c) 2015年 Kenta Tokumoto. All rights reserved.
//

import UIKit
import SushiKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        var button:UIButton = UIButton(frame: CGRectMake(0,
            20,
            CGRectGetWidth(self.view.frame)/2.0,
            CGRectGetHeight(self.view.frame)/6.0))
        button.setBackgroundColor(color: UIColor.blueColor(), forState: .Normal)
        button.setBackgroundColor(color: UIColor.greenColor(), forState: .Highlighted)
        self.view.addSubview(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

