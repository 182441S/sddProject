//
//  DonationViewCell.swift
//  sddProject
//
//  Created by 183082T  on 8/17/20.
//  Copyright © 2020 ITP312Grp2. All rights reserved.
//

import UIKit

class DonationTableViewCell: UITableViewCell {
    
    @IBOutlet var donationImage: UIImageView!
    @IBOutlet var donationName: UILabel!
    @IBOutlet var donationQuantity: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
