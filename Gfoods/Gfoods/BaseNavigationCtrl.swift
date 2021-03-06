//
//  BaseNavigationCtrl.swift
//  Gfoods
//
//  Created by 林磊 on 2017/8/25.
//  Copyright © 2017年 com.youlu. All rights reserved.
//

import UIKit

class BaseNavigationCtrl: UINavigationController {
    
    var isAnimation = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer!.delegate = nil
    }
    lazy var backBtn: UIButton = {
        //设置返回按钮属性
        let backBtn = UIButton(type: UIButtonType.custom)
        backBtn.setImage(UIImage(named: "v2_goback"), for: UIControlState())
        backBtn.titleLabel?.isHidden = true
        backBtn.addTarget(self, action: #selector(BaseNavigationCtrl.backBtnClick), for: .touchUpInside)
        backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        let btnW: CGFloat = ScreenInfo.width > 375.0 ? 50 : 44
        backBtn.frame = CGRect(x: 0, y: 0, width: btnW, height: 40)
        return backBtn
    }()
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.hidesBackButton = true
        if childViewControllers.count > 0 {
            
            UINavigationBar.appearance().backItem?.hidesBackButton = false
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
            
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    func backBtnClick() {
        popViewController(animated: isAnimation)
    }
    
}
