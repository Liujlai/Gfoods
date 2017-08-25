//
//  UIBarButtonItem+Extension.swift
//  Gfoods
//
//  Created by test on 2017/8/25.
//  Copyright © 2017年 com.youlu. All rights reserved.
//

import UIKit
extension UIBarButtonItem{
    //    类方法
    class func createItem(imageName: String,highImageName:String = "",size:CGSize = CGSize.zero,actionA:Selector) ->UIBarButtonItem {
        let btn  = UIButton()
        btn.setImage(UIImage(named:imageName), for: .normal)
        btn.setImage(UIImage(named:imageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        btn.addTarget(self, action:actionA, for:.touchUpInside)
        return UIBarButtonItem(customView: btn)
    }
    
    
    //    便利构造函数 : 1> convenience开头 2> 在构造函数中必须明确调用一个设计的构造函数（self）
    
    convenience  init(imageName: String,highImageName:String = "",size:CGSize = CGSize.zero) {
        //        创建UIButton
        let btn  = UIButton()
        //        设置btn的图片
        btn.setImage(UIImage(named:imageName), for: .normal)
        if highImageName != "" {
            btn.setImage(UIImage(named:imageName), for: .highlighted)
        }
        //        设置btn的尺寸
        if size == CGSize.zero {
            btn.sizeToFit()
            
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        //        创建UIBarButtonItem
        self.init(customView: btn)
    }
    
}
