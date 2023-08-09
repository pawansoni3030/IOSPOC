//
//  CollectionViewCell.swift
//  storyViewLayout
//
//  Created by Pawan on 29/06/23.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var ImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var imageViewWidth: NSLayoutConstraint!
    
    func setImageViewHeightWidthRation(imageHeight: CGFloat){
        ImageViewHeight.constant = imageHeight
        imageViewWidth.constant = ImageViewHeight.constant
        imageView.layer.cornerRadius = imageView.frame.size.height / 2
        imageView.layoutIfNeeded()
    }
}
