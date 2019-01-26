//
//  BaseGameModel.swift
//  douyu
//
//  Created by 悖论 on 2019/1/21.
//  Copyright © 2019 beilunyang. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    
    var tag_name: String = ""
    var icon_url: String = ""
    
    override init() {
        
    }
    
    init(dict: [String: Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
    }
}
