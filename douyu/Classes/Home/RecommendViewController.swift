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
private let kNormalItemH = kItemW / 4 * 3
private let kPrettyItemH = kItemW / 3 * 4
private let kSectionHeaderH: CGFloat = 50
private let kNormalCell = "kNormalCell"
private let kPrettyCell = "kPrettyCell"
private let kSectionHeaderView = "kSectionHeaderView"

class RecommendViewController: UIViewController { // 无主引用
    private lazy var collectionView: UICollectionView = {[unowned self] in
        // 创建流水布局
        let layout = UICollectionViewFlowLayout()
        // 设置最小行间距
        layout.minimumLineSpacing = 0
        // 设置最小item间距
        layout.minimumInteritemSpacing = kItemMargin
        // 设置section header尺寸
        layout.headerReferenceSize = CGSize(width: SCREEN_W, height: kSectionHeaderH)
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        // 创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        // 注册cell
        collectionView.register(UINib(nibName: "CollectionViewNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCell)
        collectionView.register(UINib(nibName: "CollectionViewPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCell)
        
        // 注册section header
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: kSectionHeaderView)
        
        // 设置collectionView的datasource
        collectionView.dataSource = self
        
        // 设置collectionView随父view bounces的改变而改变
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        collectionView.backgroundColor = UIColor.white
        
        // 设置layout代理，来动态获取itemSize
        collectionView.delegate = self
        
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
        // 定义cell
        var cell: UICollectionViewCell?
        
        // 通过section获取不同的cell
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCell, for: indexPath)
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCell, for: indexPath)
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 获取sectionHeader
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kSectionHeaderView, for: indexPath)
        return sectionHeader
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
}

// 实现delegateFlowLayout
extension RecommendViewController: UICollectionViewDelegateFlowLayout {
    // 动态返回itemSize
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}
