//
//  CollectionBaseCellCollectionViewCell.swift
//  douyu
//
//  Created by 悖论 on 2019/1/27.
//  Copyright © 2019 beilunyang. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionBaseCell: UICollectionViewCell {
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onlineBtn: UILabel!
    @IBOutlet weak var nickNameLabel: UILabel!
    
    var anchor: AnchorModel? {
        // 检验
        didSet {
            guard let anchor = anchor else { return }
            
            var onlineString: String = ""
            
            if anchor.online >= 10000 {
                onlineString = "\(Int(anchor.online / 10000))万在线"
            } else {
                onlineString = "\(anchor.online)在线"
            }
            
            onlineBtn.text = onlineString
            
            nickNameLabel.text = anchor.nickname
            
            guard let iconURL = URL(string: anchor.vertical_src) else { return }
            
            iconImageView.kf.setImage(with: iconURL)
        }
    }
}
