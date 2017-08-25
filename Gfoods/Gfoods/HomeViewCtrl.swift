//
//  HomeViewCtrl.swift
//  Gfoods
//
//  Created by 林磊 on 2017/8/25.
//  Copyright © 2017年 com.youlu. All rights reserved.
//

import UIKit
//CenterGo
class HomeViewCtrl: UIViewController {
    //通知网络是否可用
    let NotifyifnetUsefulChange = NSNotification.Name(rawValue:"NotifyifnetUsefulChange")
    var ifnetUseful_Vals:String!
    override func viewDidLoad() {
        //TabBarCtrl.centerGo = self
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.navigationItem.title = "首页"
        
        //处理是否有网的通知
        NotificationCenter.default.addObserver(self, selector:#selector(didNotifyifnetUseful(notification:)), name: NotifyifnetUsefulChange, object: nil)
        
        // Do any additional setup after loading the view.
        //设置按钮位置和大小
        let btn = UIButton(frame:CGRect(x:10, y:150, width:100, height:30))
        //设置按钮文字
        btn.setTitle("点击按钮", for:.normal)
        //4.文字颜色设置
        btn.setTitleColor(UIColor.blue, for: .normal)
        //6.按钮背景颜色
        btn.backgroundColor = UIColor.brown
        btn.addTarget(self, action:#selector(tapped), for:.touchUpInside)
        //self.view.addSubview(btn)
    }
    func tapped(){
        let NextView = NextViewCtrl()
        self.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(NextView , animated: true)
        self.hidesBottomBarWhenPushed = false
    }
    //    func centerGo() {
    //        print("0000s")
    //        let NextView = PlusViewCtrl()
    //        self.hidesBottomBarWhenPushed = true
    //        self.navigationController?.pushViewController(NextView , animated: true)
    //        self.hidesBottomBarWhenPushed = false
    //    }
    
    //通知处理函数
    func didNotifyifnetUseful(notification:NSNotification){
        ifnetUseful_Vals = notification.userInfo?["ifnetUseful"] as! String
    }
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.string(forKey: "ifnetUseful") == "Useable"{
            //发送异步请求
            //self.selectDatas()
        }else{
            print("\(missNetTips)")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
