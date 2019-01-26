//
//  CycleModel.swift
//  douyu
//
//  Created by 悖论 on 2019/1/27.
//  Copyright © 2019 beilunyang. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    var title: String = ""
    
    var pic_url: String = ""
    
    var room: [String: NSObject]? {
        didSet {
            guard let room = room else {
                return
            }
            anchor = AnchorModel(dict: room)
        }
    }
    
    var anchor: AnchorModel?
    
    init(dict: [String: NSObject]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
    }
}
