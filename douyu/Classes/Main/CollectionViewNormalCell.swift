//
//  CollectionViewNormalCell.swift
//  douyu
//
//  Created by 杨天燚 on 2018/12/31.
//  Copyright © 2018 beilunyang. All rights reserved.
//

import UIKit

class CollectionViewNormalCell: CollectionBaseCell {
    @IBOutlet weak var roomNameLabel: UILabel!

    override var anchor: AnchorModel? {
        didSet {
            super.anchor = anchor
            roomNameLabel.text = anchor?.room_name
        }
    }
}
