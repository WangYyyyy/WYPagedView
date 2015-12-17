//
//  WYPagedView.swift
//  WYPagedView
//
//  Created by wangyu on 15/12/15.
//  Copyright © 2015年 wangyu. All rights reserved.
//

import UIKit

typealias TapItemClosure = (item:Int) -> Void

class WYPagedView: UIView, UIScrollViewDelegate {
    
    private var tapItemClosure:TapItemClosure?
    
    private var scrollView:UIScrollView!
    
    weak var delegate:WYPagedViewDelegate?
    
    private var imageViewCount = 0
    
    ///初始化方法
    ///
    /// - parameter frame    :frame
    /// - parameter images  :UIImage数组
    /// - parameter timeInterval  :循环时间
    
    init(frame: CGRect, images:[UIImage], timeInterval:Double) {
        super.init(frame: frame)
        scrollView = UIScrollView(frame: CGRectMake(0,0,frame.size.width,frame.size.height))
        initializeImageViews(images, timeInterval: timeInterval, imageURLStrings: nil, placeholderImage: nil)
    }
    
    ///初始化方法closure
    ///
    /// - parameter frame    :frame
    /// - parameter images  :UIImage数组
    /// - parameter timeInterval  :循环时间
    /// - parameter tapItemClosure  :closure实现点击事件
    
    init(frame: CGRect, images:[UIImage], timeInterval:Double, tapItemClosure:TapItemClosure) {
        super.init(frame: frame)
        self.tapItemClosure = tapItemClosure
        scrollView = UIScrollView(frame: CGRectMake(0,0,frame.size.width,frame.size.height))
        initializeImageViews(images, timeInterval: timeInterval, imageURLStrings: nil, placeholderImage: nil)
        
    }
    
    ///初始化方法URL
    ///
    /// - parameter frame    :frame
    /// - parameter imageURLStrings  :url字符串数组
    /// - parameter timeInterval  :循环时间
    
    init(frame: CGRect, imageURLStrings:[String], timeInterval:Double) {
        super.init(frame: frame)
        scrollView = UIScrollView(frame: CGRectMake(0,0,frame.size.width,frame.size.height))
        initializeImageViews(nil, timeInterval: timeInterval, imageURLStrings: imageURLStrings, placeholderImage: nil)
    }
    
    ///初始化方法URL&Closure
    ///
    /// - parameter frame    :frame
    /// - parameter imageURLStrings  :url字符串数组
    /// - parameter timeInterval  :循环时间
    /// - parameter tapItemClosure  :closure实现点击事件
    
    init(frame: CGRect, imageURLStrings:[String], timeInterval:Double, tapItemClosure:TapItemClosure) {
        super.init(frame: frame)
        self.tapItemClosure = tapItemClosure
        scrollView = UIScrollView(frame: CGRectMake(0,0,frame.size.width,frame.size.height))
        initializeImageViews(nil, timeInterval: timeInterval, imageURLStrings: imageURLStrings, placeholderImage: nil)
    }
    
    ///初始化方法URL
    ///
    /// - parameter frame    :frame
    /// - parameter imageURLStrings  :url字符串数组
    /// - parameter placeholderImage  :加载中图片
    /// - parameter timeInterval  :循环时间
    
    init(frame: CGRect, imageURLStrings:[String], placeholderImage:UIImage, timeInterval:Double) {
        super.init(frame: frame)
        scrollView = UIScrollView(frame: CGRectMake(0,0,frame.size.width,frame.size.height))
        initializeImageViews(nil, timeInterval: timeInterval, imageURLStrings: imageURLStrings, placeholderImage: placeholderImage)
    }
    
    ///初始化方法URL&Closure
    ///
    /// - parameter frame    :frame
    /// - parameter imageURLStrings  :url字符串数组
    /// - parameter placeholderImage  :加载中图片
    /// - parameter timeInterval  :循环时间
    /// - parameter tapItemClosure  :closure实现点击事件
    
    init(frame: CGRect, imageURLStrings:[String], placeholderImage:UIImage, timeInterval:Double, tapItemClosure:TapItemClosure) {
        super.init(frame: frame)
        self.tapItemClosure = tapItemClosure
        scrollView = UIScrollView(frame: CGRectMake(0,0,frame.size.width,frame.size.height))
        initializeImageViews(nil, timeInterval: timeInterval, imageURLStrings: imageURLStrings, placeholderImage: placeholderImage)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:初始化
    
    private func initializeImageViews(images:NSArray?, timeInterval:Double, imageURLStrings:NSArray?, placeholderImage:UIImage?) {
        
        self.scrollView.pagingEnabled = true
        self.scrollView.delegate = self
        
        //view宽度&高度
        let viewWidth = self.scrollView.frame.size.width
        let viewHeight = self.scrollView.frame.size.height
        
        var count = 0
        
        if images != nil {
            imageViewCount = images!.count
            //计算设置view的总内容宽度
            self.scrollView.contentSize = CGSizeMake(viewWidth * CGFloat(images!.count + 2), viewHeight)
            count = images!.count
        }else {
            imageViewCount = imageURLStrings!.count
            //计算设置view的总内容宽度
            self.scrollView.contentSize = CGSizeMake(viewWidth * CGFloat(imageURLStrings!.count + 2), viewHeight)
            count = imageURLStrings!.count
        }
        
        //将数组数据加入到view中
        //第一张图片位置放最后一张
        //最后一张图片位置放第一张
        
        
        for var i = 0; i < count + 2; i++ {
            if i == 0 {
                //第一个位置，放最后一张图片
                
                let imageView:UIImageView
                if images != nil {
                    imageView = UIImageView(image: images!.lastObject as? UIImage)
                }else {
                    imageView = UIImageView(image: placeholderImage)
                    
                    ImageCache.imageCacheOrDownload(imageURLStrings!.lastObject as! String, imageReturnClosure: { (image, error) -> Void in
                        if image != nil {
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                imageView.image = image
                            })
                        }
                    })
                }
                imageView.frame = CGRectMake(0, 0, viewWidth, viewHeight)
                self.scrollView.addSubview(imageView)
                
                let btn = UIButton(type: .Custom)
                btn.frame = CGRectMake(0, 0, viewWidth, viewHeight)
                btn.tag = i
                btn.addTarget(self, action: "btnClick:", forControlEvents: .TouchUpInside)
                self.scrollView.addSubview(btn)
            }else if i == count + 1 {
                //最后一个位置，放第一张图片
                
                
                let imageView:UIImageView
                if images != nil {
                    imageView = UIImageView(image: images!.firstObject as? UIImage)
                }else {
                    imageView = UIImageView(image: placeholderImage)
                    ImageCache.imageCacheOrDownload(imageURLStrings!.firstObject as! String, imageReturnClosure: { (image, error) -> Void in
                        if image != nil {
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                imageView.image = image
                            })
                        }
                    })
                }
                
                imageView.frame = CGRectMake(viewWidth * CGFloat(i), 0, viewWidth, viewHeight)
                self.scrollView.addSubview(imageView)
                
                let btn = UIButton(type: .Custom)
                btn.frame = CGRectMake(viewWidth * CGFloat(i), 0, viewWidth, viewHeight)
                btn.tag = i
                btn.addTarget(self, action: "btnClick:", forControlEvents: .TouchUpInside)
                self.scrollView.addSubview(btn)
            }else {
                //如果i ＝ 1，则为第二个位置，放第一张图片，以此类推
                
                let imageView:UIImageView
                if images != nil {
                    imageView = UIImageView(image: images![i - 1] as? UIImage)
                }else {
                    imageView = UIImageView(image: placeholderImage)
                    ImageCache.imageCacheOrDownload(imageURLStrings![i - 1] as! String, imageReturnClosure: { (image, error) -> Void in
                        if image != nil {
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                imageView.image = image
                            })
                        }
                    })
                }
                
                
                imageView.frame = CGRectMake(viewWidth * CGFloat(i), 0, viewWidth, viewHeight)
                self.scrollView.addSubview(imageView)
                
                let btn = UIButton(type: .Custom)
                btn.frame = CGRectMake(viewWidth * CGFloat(i), 0, viewWidth, viewHeight)
                btn.tag = i
                btn.addTarget(self, action: "btnClick:", forControlEvents: .TouchUpInside)
                self.scrollView.addSubview(btn)
                
            }
        }
        
        //设置view默认显示第二张图片的位置
        self.scrollView.setContentOffset(CGPointMake(viewWidth, 0), animated: false)
        
        self.addSubview(scrollView)
        
        
        //计时器
        let timer = NSTimer(timeInterval: timeInterval, target: self, selector: "loop", userInfo: nil, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
        
    }
    
    //MARK:计时器方法
    func loop() {
        let width = scrollView.frame.size.width
        let page = floor((scrollView.contentOffset.x - width/2)/width) + 1
        scrollView.setContentOffset(CGPointMake(width * CGFloat(page + 1), 0), animated: true)
    }
    
    // MARK: - scrollView Delegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.x % scrollView.frame.size.width == 0 {
            let width = scrollView.frame.size.width
            let page = floor((scrollView.contentOffset.x - width/2)/width) + 1
            
            if page >= 3 {
                scrollView.setContentOffset(CGPointMake(0, 0), animated: false)
            }
        }
    }
    
    
    //MARK:btn点击
    
    internal func btnClick(btn:AnyObject) {
        
        if btn.tag == 0 {
            //第一按钮对应最后一个
            
            if delegate != nil {
                delegate?.didTapItem?(imageViewCount - 1)
            }
            
            if tapItemClosure != nil {
                tapItemClosure!(item: imageViewCount - 1)
            }
            
            
        }else if btn.tag == imageViewCount + 1 {
            //最后一个按钮对应第一个
            if delegate != nil {
                delegate?.didTapItem?(0)
            }
            
            if tapItemClosure != nil {
                tapItemClosure!(item: 0)
            }
            
            
        }else {
            //正常对应 tag - 1 == i
            if delegate != nil {
                delegate?.didTapItem?(btn.tag - 1)
            }
            
            if tapItemClosure != nil {
                tapItemClosure!(item: btn.tag - 1)
            }
        }
        
        
    }
    
}


@objc
public protocol WYPagedViewDelegate {
    optional func didTapItem(item:Int)
}

