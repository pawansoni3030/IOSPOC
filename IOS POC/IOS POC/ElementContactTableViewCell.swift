//
//  ElementContactTableViewCell.swift
//  PocCombineMajor
//
//  Created by Pawan on 19/01/23.
//

import UIKit

class ElementContactTableViewCell: UITableViewCell {
    @IBOutlet weak var profilePhoto: UIImage!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
