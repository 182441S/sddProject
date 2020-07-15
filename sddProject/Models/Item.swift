//
//  Item.swift
//  sddProject
//
//  Created by ITP312Grp2 on 1/7/20.
//  Copyright © 2020 ITP312Grp2. All rights reserved.
//

import UIKit

class Item: Codable {
    
    var itemID : String
    var itemName : String
    var itemDesc : String
    var itemImage : String
    var itemQuantity : String
    
    init(_ itemID: String, _ itemName: String, _ itemDesc: String, _ itemImage: String, _ itemQuantity: String)
    {
        self.itemID = itemID
        self.itemName = itemName
        self.itemDesc = itemDesc
        self.itemImage = itemImage
        self.itemQuantity = itemQuantity
    }

}
