//
//  WeekDayCollectionViewCell.swift
//  StepWell
//
//  Created by Pawan on 25/02/23.
//

import UIKit

class WeekDayCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var dayLabel : UILabel!
    @IBOutlet weak var DateLabel : UILabel!

    override var isSelected: Bool {
        didSet {
            // set color according to state
            self.backgroundColor = self.isSelected ? .white : #colorLiteral(red: 0.8003289104, green: 0.9228013754, blue: 0.5691844821, alpha: 1)
        }
    }
}


