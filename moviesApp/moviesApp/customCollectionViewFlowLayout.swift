//
//  customCollectionViewFlowLayout.swift
//  moviesApp
//
//  Created by Pawan on 03/07/23.
//

import UIKit

class customCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func prepare() {
        super.prepare()
        scrollDirection = .horizontal
        minimumLineSpacing = 16
        minimumLineSpacing = 16
//        itemSize = CGSize(width: UIScreen.main.bounds.width, height: 140)
    }
}
