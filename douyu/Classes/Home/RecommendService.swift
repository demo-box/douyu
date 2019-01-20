//
//  RecommendService.swift
//  douyu
//
//  Created by 悖论 on 2019/1/21.
//  Copyright © 2019 beilunyang. All rights reserved.
//

import Foundation

class RecommendService {
    
    lazy var bigDataGroup: AnchorGroup = AnchorGroup()
    lazy var prettyGroup: AnchorGroup = AnchorGroup()
    
    func requestData(_ finishCallback: () -> ()) {
        let parameters = ["limit": "4", "offset": "0", "time": Date.getCurrentTime()]
        
        
        let dGroup = DispatchGroup()
        
        // 请求推荐数据
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time": Date.getCurrentTime()]) { (result) in
            
            guard let resultDict = result as? [String: NSObject] else { return }
            
            guard let dataArray = resultDict["data"] as? [[String: NSObject]] else { return }
            
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            
            dGroup.leave()
        }
        
        // 请求颜值数据
        
        // 请求游戏数据
        
    }
}
