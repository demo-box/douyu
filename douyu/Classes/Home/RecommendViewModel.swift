//
//  RecommendService.swift
//  douyu
//
//  Created by 悖论 on 2019/1/21.
//  Copyright © 2019 beilunyang. All rights reserved.
//

import Foundation

class RecommendViewModel: BaseViewModel {
    lazy var cycleModels: [CycleModel] = [CycleModel]()
    lazy var bigDataGroup: AnchorGroup = AnchorGroup()
    lazy var prettyGroup: AnchorGroup = AnchorGroup()
    
    func requestData(_ finishCallback: @escaping () -> ()) {
        let parameters = ["limit": "4", "offset": "0", "time": Date.getCurrentTime()]
        
        
        let dGroup = DispatchGroup()
        
        // 请求推荐数据
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time": Date.getCurrentTime()]) { (result) in
            
            guard let resultDict = result as? [String: NSObject] else { return }
            
            guard let dataArray = resultDict["data"] as? [[String: NSObject]] else { return }
            
            print("推荐:\(dataArray)")
            
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            
            dGroup.leave()
        }
        
        // 请求颜值数据
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) {(result) in

            guard let resultDict = result as? [String: NSObject] else { return }
        
            guard let dataArray = resultDict["data"] as? [[String: NSObject]] else { return }
            
            print("颜值:\(dataArray)")
            
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            for dict in dataArray {
                let anchor = AnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            
            dGroup.leave()
        }
        // 请求游戏数据
        dGroup.enter()
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) {
            dGroup.leave()
        }
        
        dGroup.notify(queue: DispatchQueue.main) {
            // 请求都结束后，逐个插入到groups
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishCallback()
        }
    }
    
    func requestCycleData(_ finishCallback: () -> ()) {
        NetworkTools.requestData(.get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version": "2.300"]) { (result) in
            guard let resultDict = result as? [String: NSObject] else { return }
            
            guard let dataArray = resultDict["data"] as? [[String: NSObject]] else { return }
            
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict: dict))
            }
        }
    }
}
