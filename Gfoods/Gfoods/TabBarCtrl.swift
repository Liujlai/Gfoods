//
//  MainTabBarController.swift
//  Gfoods
//
//  Created by 林磊 on 2017/8/25.
//  Copyright © 2017年 com.youlu. All rights reserved.
//

import UIKit
//protocol CenterGo:NSObjectProtocol {
//    //设置协议方法
//    func centerGo()
//}

class TabBarCtrl: AnimationTabBarCtrl,UITabBarControllerDelegate {
    
    fileprivate var firstLoadMainTabBarController:Bool = true
    fileprivate var adImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        createMainTabBarChildViewController()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if firstLoadMainTabBarController {
            let containers = createViewContainers()
            
            createCustomIcons(containers)
            firstLoadMainTabBarController = false
        }
    }
    
    //MARK: - 初始化tabbar
    fileprivate func createMainTabBarChildViewController() {
        tabBarControllerAddChildViewController(HomeViewCtrl(), title: "首页", imageName: "v2_home", selectedImageName: "v2_home_r", tag: 0)
        tabBarControllerAddChildViewController(MarketViewCtrl(), title: "超市", imageName: "v2_order", selectedImageName: "v2_order_r", tag: 1)
        tabBarControllerAddChildViewController(PlusViewCtrl(), title: "", imageName: "v2_home", selectedImageName: "v2_home_r", tag: 2)
        tabBarControllerAddChildViewController(ShopViewCtrl(), title: "购物车", imageName: "shopCart", selectedImageName: "shopCart_r", tag: 3)
        tabBarControllerAddChildViewController(MineViewCtrl(), title: "我的", imageName: "v2_my", selectedImageName: "v2_my_r", tag: 4)
        
    }
    
    fileprivate func tabBarControllerAddChildViewController(_ childView: UIViewController, title: String, imageName: String, selectedImageName: String, tag: Int) {
        
        let vcItem = RAMAnimatedTabBarItem(title: title, image: UIImage(named: imageName), selectedImage: UIImage(named: selectedImageName))
        vcItem.tag = tag
        vcItem.animation = RAMBounceAnimation()
        childView.tabBarItem = vcItem
        
        let navigationVC = UINavigationController(rootViewController:childView)
        addChildViewController(navigationVC)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let childArr = tabBarController.childViewControllers as NSArray
        let index = childArr.index(of: viewController)
        
        if index == 2 {
            //TabBarCtrl.centerGo?.centerGo()
            return false
        }
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

