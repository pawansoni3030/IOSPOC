//
//  ContactTableViewCell.swift
//  PocCombineMajor
//
//  Created by Pawan on 20/01/23.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    @IBOutlet weak var ContactNameLabel: UILabel?
    @IBOutlet weak var ContactPositionLabel: UILabel?
    @IBOutlet weak var ContactProfilePhoto: UIImageView?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
