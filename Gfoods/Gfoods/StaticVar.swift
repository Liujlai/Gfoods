
//
//  StaticVar.swift
//  Gfoods
//
//  Created by 林磊 on 2017/8/25.
//  Copyright © 2017年 com.youlu. All rights reserved.
//

import UIKit

//MARK:-FRAME
public let ScreenInfo = UIScreen.main.bounds;
public let ScreenWidth:CGFloat = UIScreen.main.bounds.size.width
public let ScreenHeight:CGFloat = UIScreen.main.bounds.size.height
public let ScreenBounds:CGRect = UIScreen.main.bounds
let toast = ToastView()
let Url = "http://www.irockes.cn/"
//测试环境
//let dcmUrl = "http://10.10.252.252:443/api/app/"
//let picUrl = "http://10.10.252.252/"

//生产环境
let dcmUrl = "https://dc.ligo.top/api/app/"
let picUrl = "http://dc.ligo.top/"
let missNetTips = "没网络"


func AutoChangeSize( number: CGFloat) -> CGFloat {
    var number = number
    number = number * UIScreen.main.bounds.size.width / 375.0
    return number
}
//说明：
//platform :ios, ’10.0’
//target ‘Gfoods’ do
//pod "AFNetworking", "~>3.1.0"
//use_frameworks!
//pod 'Alamofire'
//pod 'SwiftIconFont'
//pod "ReachabilitySwift"
//pod "MJRefresh"
//pod 'SDWebImage', '~> 4.0'  //图片加载
//pod 'RealmSwift'   // Realm数据库
//pod 'SnapKit'   //自动布局
//pod 'SwiftyJSON'   //转JSON
//pod 'SVProgressHUD'  //提示框
//end
