//
//  ContactCell.swift
//  PocCombineMajor
//
//  Created by Pawan on 20/01/23.
//

import UIKit

class ContactCell: UITableViewCell {
    @IBOutlet weak var ContactProfilePhoto: UIImageView?
    @IBOutlet weak var ContactNameLabel: UILabel?
    @IBOutlet weak var ContactProfileLabel: UILabel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
