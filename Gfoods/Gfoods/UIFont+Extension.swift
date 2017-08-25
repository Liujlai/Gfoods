//
//  UIFont+Extension.swift
//  Gfoods
//
//  Created by test on 2017/8/25.
//  Copyright © 2017年 com.youlu. All rights reserved.
//

import UIKit

//extension UIFont{
//    class func UiFontSize(size:CGFloat) -> UIFont {
//        //Mark: ScreenInfo.height,手机屏幕的高度
//        //Mark: 568:为SE的屏幕高度，以SE为参考标准
//        return UIFont.systemFont(ofSize: size*ScreenInfo.height/568)//调整文字大小
//    }
//}

extension UIFont{
    class func UiFontSize(size:CGFloat) -> UIFont {
        //Mark: ScreenInfo.height,手机屏幕的高度
        if  (UIScreen.main.bounds.height <= 568) {  // SE 4 5S
            return UIFont.systemFont(ofSize: size)//调整文字大小
        }else if ( UIScreen.main.bounds.height > 568 && UIScreen.main.bounds.height <= 667){  // 6 6S 7
            return UIFont.systemFont(ofSize: size*1.1)//调整文字大小
        }else{ //6plus 7plus
            return UIFont.systemFont(ofSize: size*1.2)//调整文字大小
        }
    }
}
