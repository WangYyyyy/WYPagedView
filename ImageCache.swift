//
//  ImageCache.swift
//  WYPagedView
//
//  Created by wangyu on 15/12/16.
//  Copyright © 2015年 wangyu. All rights reserved.
//

import UIKit

typealias ImageReturnClosure = (image:UIImage?,error:NSError?) -> Void

class ImageCache: NSObject {

    class func imageCacheOrDownload(url:String,imageReturnClosure:ImageReturnClosure){
        
        //Document目录
        let documentPaths = (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first! as NSString)
        
        let filePath = documentPaths.stringByAppendingPathComponent((url as NSString).stringByReplacingOccurrencesOfString("/", withString: "")).stringByReplacingOccurrencesOfString(":", withString: "")
        
        let fileData = NSData(contentsOfFile: filePath)
        
        if fileData != nil {
            //本地有数据，则直接返回
//            print("加载缓存")
            imageReturnClosure(image: UIImage(data: fileData!), error: nil)
        }else {
            //本地没有数据，请求网络数据
            let req = NSMutableURLRequest(URL: NSURL(string: url)!)
            
            NSURLConnection.sendAsynchronousRequest(req, queue: NSOperationQueue()) { (response, data, er) -> Void in
                if er == nil && data != nil{
                    //请求成功，返回数据写入本地
//                    print("写入本地")
                    data!.writeToFile(filePath, atomically: true)
                    imageReturnClosure(image: UIImage(data: data!), error: nil)
                    
                }else {
                    //出现错误，返回错误信息
                    imageReturnClosure(image: nil, error: er)
                }
            }
        }
        
    }
}
