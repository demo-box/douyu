//
//  PageContentView.swift
//  douyu
//
//  Created by 杨天燚 on 2018/11/24.
//  Copyright © 2018 beilunyang. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(progress: CGFloat, sourceIdx: Int, targetIdx: Int)
}

class PageContentView: UIView {
    private let contentCellId = "contentCellId"
    private var childVcs: [UIViewController]
    private var parentVc: UIViewController
    private var startOffsetX: CGFloat = 0
    private var isForbidScrollDelegate: Bool = false
    weak var delegate: PageContentViewDelegate?
    
    // 懒初始化collectionView
    private lazy var collectionView: UICollectionView = {
        // 创建layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        // 创建UICollectionView
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contentCellId)
        return collectionView
    }()
    
    init(frame: CGRect, childVcs: [UIViewController], parentVc: UIViewController) {
        self.childVcs = childVcs
        self.parentVc = parentVc
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageContentView {
    func initUI() {
        // 将所有的子控制器添加到父控制器中
        for vc in childVcs {
            parentVc.addChild(vc)
        }
        addSubview(collectionView)
    }
}

extension PageContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellId, for: indexPath)
        // 防止重复利用cell可能导致的重复添加vc.view
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let vc = childVcs[indexPath.item]
        vc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(vc.view)
        return cell
    }
}

extension PageContentView {
    func setCurrentIdx(currentIdx: Int) {
        // 点击title导致scroll时，不需要执行代理方法
        isForbidScrollDelegate = true
        
        let offsetX = CGFloat(currentIdx) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}

extension PageContentView : UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        print("begin")
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isForbidScrollDelegate {
            return
        }
        
        print("scroll")
        var progress: CGFloat = 0
        var sourceIdx: Int = 0
        var targetIdx: Int = 0
        
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        // 左移
        if currentOffsetX > startOffsetX {
            // 计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            sourceIdx = Int(currentOffsetX / scrollViewW)
            targetIdx = sourceIdx + 1
            // 计算targetIdx
            if targetIdx >= childVcs.count {
                targetIdx = childVcs.count - 1
            }
            // 如果完全划过去了
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIdx = sourceIdx
            }
        } else {
            // 右移
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            targetIdx = Int(currentOffsetX / scrollViewW)
            
            sourceIdx = targetIdx + 1
            
            if sourceIdx >= childVcs.count {
                sourceIdx = childVcs.count - 1
            }
        }
        delegate?.pageContentView(progress: progress, sourceIdx: sourceIdx, targetIdx: targetIdx)
    }
}
