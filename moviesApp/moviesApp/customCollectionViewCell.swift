//
//  customCollectionViewCell.swift
//  moviesApp
//
//  Created by Pawan on 04/07/23.
//

import UIKit

class customCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var alphaView: UIView!
    @IBOutlet weak var imageViewWidth: NSLayoutConstraint!
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    
    func zoomCenterCell(){
        UIView.animate(withDuration: 0.2){
            self.transform = CGAffineTransform(scaleX: 1.50, y: 1.50)
            self.layer.cornerRadius = 20
        }
        let generator  = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    func zoomOutCell(){
        UIView.animate(withDuration: 0.2){
            self.layer.cornerRadius = 20
            self.transform = CGAffineTransform.identity
        }
    }
}
