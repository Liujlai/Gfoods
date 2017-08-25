//
//  AppDelegate.swift
//  Gfoods
//
//  Created by 林磊 on 2017/8/25.
//  Copyright © 2017年 com.youlu. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift
import ReachabilitySwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let reachability = Reachability()!
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.backgroundColor = UIColor.white
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.isTranslucent = false
        //接收引导页"立即体验"按钮点击事件的通知
        NotificationCenter.default.addObserver(self, selector: #selector(AppDelegate.loadHomeViewCtrl), name: NSNotification.Name(rawValue: "AppStartCtrlDidFinish"), object: nil)
        createKeyWindow()
        
        
        // 检测网络连接状态
        if reachability.isReachable {
            //print("网络连接：可用")
            DispatchQueue.main.async {
                UserDefaults .standard.set("Useable", forKey: "ifnetUseful")
                UserDefaults .standard .synchronize()
            }
        } else {
            //print("网络连接：不可用")
            DispatchQueue.main.async {
                UserDefaults .standard.set("unUseable", forKey: "ifnetUseful")
                UserDefaults .standard .synchronize()
                //self.toast.showToast(text: "\(missNetTips)", pos: .Mid)
            }
        }
        reachability.whenReachable = { reachability in
            // this is called on a background thread, but UI updates must
            // be on the main thread, like this:
            DispatchQueue.main.async {
                //self.toast.showToast(text: "网络可用", pos: .Mid)
                UserDefaults .standard.set("Useable", forKey: "ifnetUseful")
                UserDefaults .standard .synchronize()
                let NotifyifnetUsefulChange = NSNotification.Name(rawValue:"NotifyifnetUsefulChange")
                NotificationCenter.default.post(name:NSNotification.Name(rawValue:"NotifyifnetUsefulChange"), object: nil, userInfo: ["ifnetUseful":"Useable"])
            }
        }
        
        reachability.whenUnreachable = { reachability in
            DispatchQueue.main.async {
                UserDefaults .standard.set("unUseable", forKey: "ifnetUseful")
                UserDefaults .standard .synchronize()
                let NotifyifnetUsefulChange = NSNotification.Name(rawValue:"NotifyifnetUsefulChange")
                NotificationCenter.default.post(name:NSNotification.Name(rawValue:"NotifyifnetUsefulChange"), object: nil, userInfo: ["ifnetUseful":"unUseable"])
                toast.showToast(text: "\(missNetTips,12345)", pos: .Mid)
            }
        }
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        return true
    }
    fileprivate func createKeyWindow() {
        window = UIWindow(frame: ScreenBounds)
        window?.makeKeyAndVisible()
        
        var ifFirst:Results<IfFirst>?
        //使用默认的数据库
        let realm = try! Realm()
        //realm数据库存是否是第一次进入App
        ifFirst = realm.objects(IfFirst.self)
        if (ifFirst?.isEmpty)! {
            window?.rootViewController = AppStartCtrl()
        }else{
            //不是第一次打开应用
            loadHomeViewCtrl()
        }
    }
    func loadHomeViewCtrl() {
        window?.rootViewController = TabBarCtrl()
        
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Gfoods")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

