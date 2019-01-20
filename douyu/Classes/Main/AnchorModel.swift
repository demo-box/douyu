//
//  AnchorModel.swift
//  douyu
//
//  Created by 悖论 on 2019/1/21.
//  Copyright © 2019 beilunyang. All rights reserved.
//

import UIKit

class AnchorModel: NSObject {
    var room_id: Int = 0
    
    var vertical_src: String = ""
    
    var isVertical: Int = 0
    
    var room_name: String = ""
    
    var nickname: String = ""
    
    var online: Int = 0
    
    var anchor_city: String = ""
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }

}
