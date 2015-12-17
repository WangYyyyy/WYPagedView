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
        
//        let images = NSArray(objects: UIImage(named: "demo0.jpg")!, UIImage(named: "demo1.jpg")!, UIImage(named: "demo2.jpg")!)
        
        let imagesURL = ["http://pic38.nipic.com/20140215/12359647_224250202132_2.jpg","http://img.article.pchome.net/00/35/62/34/pic_lib/wm/Zhiwu37.jpg","http://www.33.la/uploads/201405sy/xiaoxi/32.jpg"]
        
        //        let view = WYPagedView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 200), images: images as! [UIImage], timeInterval: 2)
        
//        let view = WYPagedView(frame: CGRectMake(0, (self.view.frame.size.height - self.view.frame.size.width * 0.666)/2, self.view.frame.size.width, self.view.frame.size.width * 0.666), images: images as! [UIImage], timeInterval: 2) { (item) -> Void in
//            print(item)
//        }
        
//        let view = WYPagedView(frame: CGRectMake(0, (self.view.frame.size.height - self.view.frame.size.width * 0.666)/2, self.view.frame.size.width, self.view.frame.size.width * 0.666),imagesURL imageURLStrings: , timeInterval: 2)
        
        let view = WYPagedView(frame: CGRectMake(0, (self.view.frame.size.height - self.view.frame.size.width * 0.666)/2, self.view.frame.size.width, self.view.frame.size.width * 0.666), imageURLStrings: imagesURL, placeholderImage: UIImage(named: "demo0.jpg")!, timeInterval: 2)
        
        
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

