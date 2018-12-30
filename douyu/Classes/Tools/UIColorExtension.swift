//
//  UIColorExtension.swift
//  douyu
//
//  Created by 杨天燚 on 2018/11/25.
//  Copyright © 2018 beilunyang. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}
