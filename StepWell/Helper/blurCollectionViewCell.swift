//
//  blurCollectionViewCell.swift
//  StepWell
//
//  Created by Pawan on 05/03/23.
//

import UIKit

class blurCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
            super.init(frame: frame)
            commonInit()
        }
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            commonInit()
        }
        private func commonInit() {

            contentView.backgroundColor = .clear
            
            let blurEffect = UIBlurEffect(style: .light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(blurEffectView)
            
            blurEffectView.layer.cornerRadius = 20
            blurEffectView.clipsToBounds = true

            
            let g = contentView.layoutMarginsGuide
            NSLayoutConstraint.activate([
                // constrain blur view to all 4 sides of contentView
                blurEffectView.topAnchor.constraint(equalTo: g.topAnchor, constant: 0.0),
                blurEffectView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 0.0),
                blurEffectView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: 0.0),
                blurEffectView.bottomAnchor.constraint(equalTo: g.bottomAnchor, constant: 0.0),

            ])
            
        }


}
