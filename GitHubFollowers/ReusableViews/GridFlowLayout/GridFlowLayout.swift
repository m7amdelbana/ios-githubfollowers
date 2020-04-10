//
//  GridFlowLayout.swift
//  GitHubFollowers
//
//  Created by Mohamed Elbana on 3/31/20.
//  Copyright © 2020 Mohamed Elbana. All rights reserved.
//

import UIKit

class GridFlowLayout: UICollectionViewFlowLayout {
    
    init(width: CGFloat, columns: Int) {
        super.init()
        configure(width: width, columns: columns)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(width: CGFloat, columns: Int) {
        let padding: CGFloat = 15
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * (CGFloat(columns) - 1))
        let itemWidth = availableWidth / 3
        
        self.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        self.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
    }
}
