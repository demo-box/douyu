//
//  CollectionViewPrettyCell.swift
//  douyu
//
//  Created by 杨天燚 on 2018/12/31.
//  Copyright © 2018 beilunyang. All rights reserved.
//

import UIKit

class CollectionViewPrettyCell: CollectionBaseCell {
    @IBOutlet weak var cityBtn: UIButton!
    
    override var anchor: AnchorModel? {
        didSet {
            super.anchor = anchor
            cityBtn.setTitle(anchor?.anchor_city, for: .normal)
        }
    }
}
