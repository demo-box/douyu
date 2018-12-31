//
//  RecommendViewController.swift
//  douyu
//
//  Created by 杨天燚 on 2018/12/31.
//  Copyright © 2018 beilunyang. All rights reserved.
//

import UIKit


private let kItemMargin: CGFloat = 10
private let kItemW = (SCREEN_W - 3 * kItemMargin) / 2
private let kItemH = kItemW / 3 * 2
private let kSectionHeaderH: CGFloat = 50
private let kNormalCell = "kNormalCell"
private let kSectionHeaderView = "kSectionHeaderView"

class RecommendViewController: UIViewController { // 无主引用
    private lazy var collectionView: UICollectionView = {[unowned self] in
        // 创建流水布局
        let layout = UICollectionViewFlowLayout()
        // 设置item尺寸
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        // 设置最小行间距
        layout.minimumLineSpacing = 0
        // 设置最小item间距
        layout.minimumInteritemSpacing = kItemMargin
        // 设置section header尺寸
        layout.headerReferenceSize = CGSize(width: SCREEN_W, height: kSectionHeaderH)
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        // 创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCell)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kSectionHeaderView)
        
        collectionView.backgroundColor = UIColor.blue
        
        // 设置collectionView的datasource
        collectionView.dataSource = self
        
        // 设置collectionView随父view bounces的改变而改变
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
}

// 初始化UI
extension RecommendViewController {
    private func initUI() {
        view.addSubview(collectionView)
    }
}

// dataSource
extension RecommendViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCell, for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 获取sectionHeader
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kSectionHeaderView, for: indexPath)
        sectionHeader.backgroundColor = UIColor.green
        return sectionHeader
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
}
