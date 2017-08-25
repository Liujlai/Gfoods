//
//  UIColor+Extension.swift
//  Gfoods
//
//  Created by test on 2017/8/25.
//  Copyright © 2017年 com.youlu. All rights reserved.
//


import UIKit

extension UIColor{
    
    //    扩充构造函数，必须扩充便利构造函数，明确的调用 self.init（）
    convenience init(r:CGFloat,g: CGFloat,b:CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1.0)
    }
    class func colorWithCustom(_ r: CGFloat, g:CGFloat, b:CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1)
    }
}
