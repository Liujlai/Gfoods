//
//  AppStartCollectCell.swift
//  Gfoods
//
//  Created by 林磊 on 2017/8/25.
//  Copyright © 2017年 com.youlu. All rights reserved.
//

import UIKit
import RealmSwift
//realm数据库存是否是第一次进入App
class IfFirst:Object{
    //类型名
    dynamic var ifIs = ""
}
class AppStartCollectCell: UICollectionViewCell {
    
    
    fileprivate let newImageView = UIImageView(frame: ScreenBounds)
    fileprivate let nextBtn = UIButton(frame: CGRect(x: (ScreenWidth - 100)*0.5, y: ScreenHeight - 110, width: 100, height: 33))
    
    var newImage:UIImage? {
        didSet{
            newImageView.image = newImage
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        newImageView.contentMode = UIViewContentMode.scaleAspectFill
        contentView.addSubview(newImageView)
        
        nextBtn.setBackgroundImage(UIImage(named: "icon_next"), for: UIControlState())
        nextBtn.addTarget(self, action: #selector(AppStartCollectCell.nextBtnClick), for: .touchUpInside)
        nextBtn.isHidden = true
        contentView.addSubview(nextBtn)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setNextBtnHidden(_ hidden:Bool) {
        nextBtn.isHidden = hidden
    }
    
    func nextBtnClick() {
//        UserDefaults.standard.set(true, forKey:"ifO")
//        UserDefaults .standard .synchronize()
        //使用默认的数据库
        let realm = try! Realm()
        //查询所有的消费记录
        let items = realm.objects(IfFirst.self)
        //已经有记录的话就不插入了
        if items.count>0 {
            return
        }
        let item = IfFirst()
        item.ifIs = "ture"
        // 数据持久化操作（类型记录也会自动添加的）
        try! realm.write {
            realm.add(item)
        }
        NotificationCenter.default.post(name: Notification.Name(rawValue: "AppStartCtrlDidFinish"), object: nil)
    }
    
}
