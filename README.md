# WYPagedView
#####简单的轮播图滚动view，可使用closure或delegate的方式获取点击事件。
#####支持URL缓存，离线下通过URL缓存加载图片
---
支持iOS 7.0+

---

# 使用方法
#####直接设置frame和图片集合 add到指定view即可使用
		let view = WYPagedView(frame: CGRectMake(0, 0, 0, 0), images: images, timeInterval: 2)
#####通过图片的URL集合 还可以设置加载中的默认图片 add到指定view即可使用
		let view = WYPagedView(frame: CGRectMake(0, 0, 0, 0), imageURLStrings: imagesURLs, placeholderImage: UIImage(), timeInterval: 2)

---
# 点击事件
#####通过delegate实现响应
1.实现 WYPagedViewDelegate 协议  
2.设置代理 view.delegate = self  
3.实现 func didTapItem(item: Int)方法  
4.item 则是点击的参数数组的index值  
#####通过closure实现
1.初始化中选择带有closure tapItemClosure 的初始化方法  
例如：  
        
        
        let view = WYPagedView(frame: CGRectMake(0, 0, 0, 0), images: images, timeInterval: 2) { (item) -> Void in
        	print(item)
        }

2.item 则是点击的参数数组的index值

---
#Log
---
2015.12.14  
写的一个超级简单的轮播图view，传入图片数组即可实现轮播图效果

2015.12.17  
增加了可以通过图片URL的String集合，加载图片并且本地缓存，支持离线。




