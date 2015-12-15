//
//  ViewController.swift
//  WYPagedView
//
//  Created by wangyu on 15/12/12.
//  Copyright © 2015年 wangyu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, WYPagedViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let images = NSArray(objects: UIImage(named: "demo0.jpg")!, UIImage(named: "demo1.jpg")!, UIImage(named: "demo2.jpg")!)
        
        //        let view = WYPagedView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 200), images: images as! [UIImage], timeInterval: 2)
        
        let view = WYPagedView(frame: CGRectMake(0, (self.view.frame.size.height - self.view.frame.size.width * 0.666)/2, self.view.frame.size.width, self.view.frame.size.width * 0.666), images: images as! [UIImage], timeInterval: 2) { (item) -> Void in
            print(item)
        }
        
        
        
        view.delegate = self
        self.view.addSubview(view)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func didTapItem(item: Int) {
        print(item)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

