//
//  ItemTableViewCell.swift
//  sddProject
//
//  Created by ITP312Grp2 on 1/7/20.
//  Copyright © 2020 ITP312Grp2. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    @IBOutlet weak var itemNameLabel: UILabel!
    
    @IBOutlet weak var itemDescLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
