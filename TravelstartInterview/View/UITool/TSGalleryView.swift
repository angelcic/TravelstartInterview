//
//  TSGalleryView.swift
//  TravelstartInterview
//
//  Created by iching chen on 2019/11/3.
//  Copyright © 2019 ichingchen. All rights reserved.
//

import UIKit

class TSGalleryView: UIView {
    var scrollView = UIScrollView()
    
    var datas: [String] = [] {
        didSet {
            setupScrollView()
        }
    }
    
    let screenWidth = UIScreen.main.bounds.width
    let imageViewScale: CGFloat = 2 / 3
    
    var imageIndex: Int = 0 {
        didSet {
            scrollToImage(at: imageIndex)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        initView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        initView()
    }

    private func initView() {

        backgroundColor = UIColor.white
        
        self.frame = CGRect(x: 0,
                            y: 0,
                            width: screenWidth,
                            height: screenWidth * imageViewScale)
        
        self.addSubview(scrollView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
    func setupGallery(imageURLs: [String], index: Int = 0) {
        datas = imageURLs
        imageIndex = index
    }
    
    func setupScrollView() {
        let imageCount = datas.count   // 依據多少張圖片調整 scrollView 寬度
        let scrollViewHeight = screenWidth * imageViewScale // 寬高比3:2
        let scrollViewContentWidth = screenWidth * CGFloat(integerLiteral: imageCount)
        
        scrollView.frame.size = CGSize(width: screenWidth, height: scrollViewHeight)
        
        scrollView.contentSize = CGSize(width: scrollViewContentWidth, height: scrollViewHeight)
        
        // 不顯示垂直、水平捲動控制條
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false // 超過 ScrollView 範圍自動回彈，false 時不能捲動超過邊界
        scrollView.isPagingEnabled = true // 一次捲動一頁的範圍
        scrollView.delegate = self
        
        prepareImageView(screenWidth, scrollViewHeight)
                
    }
    
    func prepareImageView(_ superViewWidth: CGFloat,
                          _ superViewHeight: CGFloat) {
        
        var imageView = UIImageView()
        let imageViewWidth = superViewWidth
        let imageViewHeight = superViewHeight
        
        for (imageViewIndex, urlString) in datas.enumerated() {
            // 依據顯示圖片數量增加預設 imageView
            
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageViewWidth, height: imageViewHeight))
            
            imageView.center = CGPoint(x: imageViewWidth * (0.5 + CGFloat(imageViewIndex)), y: imageViewHeight * 0.5)
            
            imageView.clipsToBounds = true // 裁切掉多餘的圖片以免蓋到別張圖片
            imageView.contentMode = UIView.ContentMode.scaleAspectFill
            imageView.loadImage(urlString)
            
            scrollView.addSubview(imageView)
        }
        
    }
    
    func scrollToImage(at index: Int) {
        let position = CGPoint(x: CGFloat(index) * screenWidth, y: 0)
        scrollView.setContentOffset(position, animated: false)
    }
    
}

extension TSGalleryView: UIScrollViewDelegate {
    
}
