//
//  startNetRequest.swift
//  Gfoods
//
//  Created by 林磊 on 2017/8/25.
//  Copyright © 2017年 com.youlu. All rights reserved.

import UIKit
import AFNetworking
import Alamofire
// Swift的枚举支持任意数据类型,不需要,分隔
enum PSHTTPMethod{
    case GET
    case POST
}
//为请求添加ssid
//let ssid = UserDefaults.standard.object(forKey: "ssid") as? String
/// 网络管理工具   同步请求
class SynchronousNetWork: AFHTTPSessionManager {
    // 单例
    static let shared = SynchronousNetWork()
    // MARK:- get请求
    func getWithPath(options: String,paras: String?,ssid:String?,success: @escaping ((_ result: Any) -> ()),failure: @escaping ((_ error: Error) -> ())) {
        let Urls = URL.init(string: Url+options)
        let request = NSMutableURLRequest.init(url: Urls!)
        request.timeoutInterval = 30
        request.httpMethod = "\(PSHTTPMethod.GET)"
        request.httpBody = paras?.data(using: String.Encoding.utf8)
        if(ssid != nil || ssid != ""){
            request.setValue(ssid, forHTTPHeaderField: "ssid")
        }
        // 3、响应对象
        var response:URLResponse?
        do {
            // 4、发出请求
            let  received =  try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: &response)
            if let result = try? JSONSerialization.jsonObject(with: received, options: .allowFragments){
                success(result)
            }
        } catch let error{
            failure(error)
        }
    }
    // MARK:- post请求
    func postWithPath(options: String,paras: Dictionary<String, Any>?,ssid:String?,success: @escaping ((_ result: Any) -> ()),failure: @escaping ((_ error: Error) -> ())) {
        let Urls = URL.init(string: dcmUrl+options)
        let data = try! JSONSerialization.data(withJSONObject: paras, options: JSONSerialization.WritingOptions.prettyPrinted)
        var str = ""
        let Str = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        str = str + Str!
        let request = NSMutableURLRequest.init(url: Urls!)
        request.timeoutInterval = 30
        request.httpMethod = "\(PSHTTPMethod.POST)"
        request.httpBody = str.data(using: String.Encoding.utf8)
        if(ssid != nil || ssid != ""){
            request.setValue(ssid, forHTTPHeaderField: "ssid")
        }
        // 5、响应对象
        var response:URLResponse?
        do {
            // 4、发出请求
            let  received =  try NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: &response)
            if let result = try? JSONSerialization.jsonObject(with: received, options: .allowFragments){
                success(result)
            }
        } catch let error{
            failure(error)
        }
    }
}
/// 网络管理工具   异步请求
class AsynchronousNetWork: AFHTTPSessionManager  {
    // 单例
    static let shared = AsynchronousNetWork()
    // MARK:- get请求
    func getWithPath(options: String,paras: String?,ssid:String?,success: @escaping ((_ result: Any) -> ()),failure: @escaping ((_ error: Error) -> ())) {
        let Urls = URL.init(string: Url+options)
        let request = NSMutableURLRequest.init(url: Urls!)
        request.timeoutInterval = 30
        request.httpMethod = "\(PSHTTPMethod.GET)"
        request.httpBody = paras?.data(using: String.Encoding.utf8)
        if(ssid != nil || ssid != ""){
            request.setValue(ssid, forHTTPHeaderField: "ssid")
        }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, respond, error) in
            if let data = data {
                if let result = try? JSONSerialization.jsonObject(with: data, options: .allowFragments){
                    success(result)
                }
            }else {
                failure(error!)
            }
        }
        dataTask.resume()
    }
    // MARK:- post请求
    func postWithPath(options: String,paras: Dictionary<String, Any>?,ssid:String?,success: @escaping ((_ result: Any) -> ()),failure: @escaping ((_ error: Error) -> ())) {
        let Urls = URL.init(string: dcmUrl+options)
        let data = try! JSONSerialization.data(withJSONObject: paras, options: JSONSerialization.WritingOptions.prettyPrinted)
        var str = ""
        let Str = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        str = str + Str!
        let request = NSMutableURLRequest.init(url: Urls!)
        request.timeoutInterval = 30
        request.httpMethod = "\(PSHTTPMethod.POST)"
        request.httpBody = str.data(using: String.Encoding.utf8)
        if(ssid != nil || ssid != ""){
            request.setValue(ssid, forHTTPHeaderField: "ssid")
        }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, respond, error) in
            if let data = data {
                if let result = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    success(result)
                }
            }else {
                failure(error!)
            }
        }
        dataTask.resume()
    }
}

class NetworkTools {
    
    func requestData(_ type : PSHTTPMethod, options : String, parameters : [String : Any]? = nil, ssid:String, finishedCallback :  @escaping (_ result : Any) -> ()) {
        // 1.获取类型
        let method = type == .GET ? HTTPMethod.get : HTTPMethod.post
        // 2.发送网络请求
        Alamofire.request(dcmUrl+options, method: method, parameters: parameters,encoding: JSONEncoding.default, headers:["ssid":ssid]).responseJSON{ (response) in
            //print(response.request?.allHTTPHeaderFields)//打印请求头信息
            // 3.获取结果
            guard let result = response.result.value else {
                return
            }
            // 4.将结果回调出去
            finishedCallback(result)
        }
    }
}


let netSyStart=SynchronousNetWork()     //同步请求对象
let netAsyStart=AsynchronousNetWork()   //异步请求对象
let AlamofireStart=NetworkTools()   //异步请求对象


//使用方式：
//let param = ["opr":"index_info"] as [String : Any]
//netAsyStart.postWithPath(options:"info.do",paras:param,ssid:self.ssid,success: { (result) in
//    if JSON(result)["status"] == 0{
//    }
//}){ (error) in
//    print(error)
//}


//func getInfos(_ finishCallback : @escaping () -> ()) {
//    let paras = ["opr":"order_info","data":["serial_num":"1502756414844606197719"]] as [String : Any]
//    AlamofireStart.requestData(.POST, options:"order.do",parameters:paras, ssid: ssid) { (result) in
//        for data in self.dataArr {
//            let model = DataModels(dict: data)
//            self.dataModels.append(model)
//        }
//        finishCallback()
//    }
//    
//}





