//
//  LSXNewFeatureViewFlowLayout.swift
//  椰海雅客微博
//
//  Created by 李莎鑫 on 2017/4/7.
//  Copyright © 2017年 李莎鑫. All rights reserved.
//

import UIKit

class LSXNewFeatureViewFlowLayout: UICollectionViewFlowLayout {

    override func prepare() {
        itemSize = UIScreen.main.bounds.size
        minimumLineSpacing = 0
        minimumInteritemSpacing = 0
        
        scrollDirection = .horizontal
        collectionView?.isPagingEnabled = true
        collectionView?.bounces = false
        collectionView?.showsHorizontalScrollIndicator = false
    }
}
