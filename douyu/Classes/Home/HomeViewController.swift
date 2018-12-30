//
//  HomeViewController.swift
//  douyu
//
//  Created by 杨天燚 on 2018/11/18.
//  Copyright © 2018年 beilunyang. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let titleViewHeight: CGFloat = 40
    private lazy var pageTitleView: PageTtileView = {[weak self] in
        let titleFrame = CGRect(x: 0.0, y: STATUS_BAR_H + NAVIGATION_BAR_H, width: SCREEN_W, height: titleViewHeight)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTtileView(frame: titleFrame, titles: titles)
        titleView.backgroundColor = UIColor.white
        titleView.delegate = self
        return titleView
    }()
    
    private lazy var pageContentView: PageContentView = {
        let contentFrame = CGRect(x: 0.0, y: STATUS_BAR_H + NAVIGATION_BAR_H + titleViewHeight, width: SCREEN_W, height: SCREEN_H - STATUS_BAR_H - NAVIGATION_BAR_H - titleViewHeight)
        var childVcs = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
            childVcs.append(vc)
        }
        let pageContentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentVc: self)
        pageContentView.delegate = self
        return pageContentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
}

extension HomeViewController {
    private func initUI() {
        // 初始化pageTitleView
        view.addSubview(pageTitleView)
        // 初始化pageContentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
        automaticallyAdjustsScrollViewInsets = false
        // 设置navigationBar的背景色
        navigationController?.navigationBar.backgroundColor = UIColor.white
    }
}

extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(currentIdx: Int) {
        pageContentView.setCurrentIdx(currentIdx: currentIdx)
    }
}

extension HomeViewController : PageContentViewDelegate {
    func pageContentView(progress: CGFloat, sourceIdx: Int, targetIdx: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIdx: sourceIdx, targetIdx: targetIdx)
    }
}

