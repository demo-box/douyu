//
//  DateExtension.swift
//  douyu
//
//  Created by 悖论 on 2019/1/21.
//  Copyright © 2019 beilunyang. All rights reserved.
//

import Foundation

extension Date {
    static func getCurrentTime() -> String {
        let nowDate = Date()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return String(interval)
    }
}
