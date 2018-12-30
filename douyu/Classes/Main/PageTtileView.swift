//
//  PageTtileView.swift
//  douyu
//
//  Created by 杨天燚 on 2018/11/18.
//  Copyright © 2018 beilunyang. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class {
    func pageTitleView(currentIdx: Int)
}

private let KNormalColor: (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let KSelectColor: (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

// 自定义View
class PageTtileView: UIView {
    private let underline_h: CGFloat = 2
    private var titles: [String]
    private var currentIdx = 0
    private var titleLabels = [UILabel]()
    private var scrollLine: UIView!
    
    weak var delegate: PageTitleViewDelegate?
    
    // 懒初始化scrollView
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        return scrollView
    }()
    
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageTtileView {
    // 设置UI
    private func initUI() {
        addSubview(scrollView)
        scrollView.frame = bounds
        initTitleLabel()
        initBottomLineAndScrollLine()
    }
    
    // 设置title label
    private func initTitleLabel() {
        let labelW = frame.width / CGFloat(titles.count)
        let labelH = frame.height - CGFloat(underline_h)
        
        for (index,title) in titles.enumerated() {
            // 设置label
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: KNormalColor.0, g: KNormalColor.1, b: KNormalColor.2)
            label.textAlignment = .center
            
            // 设置label frame
            let labelX = labelW * CGFloat(index)
            let labelY = CGFloat(0)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            titleLabels.append(label)
            scrollView.addSubview(label)
            
            // 给label添加手势
            label.isUserInteractionEnabled = true
            let labelGesture = UITapGestureRecognizer(target: self, action: #selector(self.titleLableClick(tapGesture:)))
            label.addGestureRecognizer(labelGesture)
        }
    }
    
    private func initBottomLineAndScrollLine() {
        // 设置bottomLine
        let bottomLine = UIView()
        let lineH: CGFloat = 0.5
        bottomLine.backgroundColor = UIColor.lightGray
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        // 设置scrollLine
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor(r: KSelectColor.0, g: KSelectColor.1, b: KSelectColor.2)
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - underline_h, width: firstLabel.frame.width, height: underline_h)
        addSubview(scrollLine)
        self.scrollLine = scrollLine
    }
}

// 事件处理器
extension PageTtileView {
    @objc private func titleLableClick(tapGesture: UITapGestureRecognizer) {
        print("title view click")
        // 获取当前点击的label
        guard let currentLabel = tapGesture.view as? UILabel else { return }
        // 获取老label
        let oldLabel = titleLabels[currentIdx]
        
        // 切换label颜色
        currentLabel.textColor = UIColor(r: KSelectColor.0, g: KSelectColor.1, b: KSelectColor.2)
        oldLabel.textColor = UIColor(r: KNormalColor.0, g: KNormalColor.1, b: KNormalColor.2)
        
        // 重新设置currentIdx的值
        currentIdx = currentLabel.tag
        
        // 移动下划线
        let scrollLineX = CGFloat(currentLabel.tag) * scrollLine!.frame.width
        
        // 动画滚动
        UIView.animate(withDuration: 0.2) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        delegate?.pageTitleView(currentIdx: currentIdx)
    }
}

// 对外暴露的方法
extension PageTtileView {
    func setTitleWithProgress(_ progress: CGFloat, sourceIdx: Int, targetIdx: Int) {
        let sourceLabel = titleLabels[sourceIdx]
        let targetLabel = titleLabels[targetIdx]
        
        // 下划线移动
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        // 取出颜色的范围
        let colorDelta = (KSelectColor.0 - KNormalColor.0, KSelectColor.1 - KNormalColor.1, KSelectColor.2 - KSelectColor.2)
        
        // 变化sourceLabel
        sourceLabel.textColor = UIColor(r: KSelectColor.0 - colorDelta.0 * progress, g: KSelectColor.1 - colorDelta.1 * progress, b: KSelectColor.2 - colorDelta.2 * progress)
        
        // 变化targetLabel
        targetLabel.textColor = UIColor(r: KNormalColor.0 + colorDelta.0 * progress, g: KNormalColor.1 + colorDelta.1 * progress, b: KNormalColor.2 + colorDelta.2 * progress)
        
        // 记录新idx
        currentIdx = targetIdx
    }
}
