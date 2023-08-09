//
//  CountryCodeCell.swift
//  
//
//  Created by Pawan on 21/02/23.
//

import UIKit

class CountryCodeCell: UITableViewCell {
    @IBOutlet weak var countryFlagLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
