//
//  ViewController.swift
//  CJDialogBox
//
//  Created by Jarvis on 14-8-4.
//  Copyright (c) 2014年 森哲. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var dialogBox : CJDialogBox? = CJDialogBox(frame: CGRectMake(20, 120, 200, 100), fillColor: UIColor.grayColor(), arcRaidus: 5.0)
        dialogBox?.setupTriangle(.arrowDirectionLeft, height: 15, apexDirection: 30, bottomDirection1: 18, bottomDirection2: 32)
        self.view.addSubview(dialogBox)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

