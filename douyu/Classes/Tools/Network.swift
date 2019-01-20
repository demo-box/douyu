//
//  Network.swift
//  douyu
//
//  Created by 悖论 on 2019/1/20.
//  Copyright © 2019 beilunyang. All rights reserved.
//

import Foundation
import Alamofire

enum MethodType {
    case get, post
}

// 门面模式，方便日后迁移第三方库
class NetworkTools {
    class func requestData(_ type: MethodType, URLString: String, parameters: [String: Any]? = nil, finishedCallback: @escaping (_ result: Any) -> ()) {
    
        // 获取请求方式
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        
        // 发送请求
        Alamofire.request(URLString, method: method, parameters: parameters).responseJSON {
            (response) in
            
            guard let result = response.result.value else {
                print(response.result.error as Any)
                return
            }
            
            finishedCallback(result)
        }
        
    }
}

