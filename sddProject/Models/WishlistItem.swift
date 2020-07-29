//
//  WishlistItem.swift
//  sddProject
//
//  Created by ITP312Grp2 on 27/7/20.
//  Copyright © 2020 ITP312Grp2. All rights reserved.
//

import UIKit

class WishlistItem: Codable {
    
    var itemID : String
    var itemName : String
    var itemDesc : String
    var itemImage : String
    var itemQuantity : String
    var userID : String
    var uniqueID: String
    
    init(_ itemID: String, _ itemName: String, _ itemDesc: String, _ itemImage: String, _ itemQuantity: String, _ userID: String, _ uniqueID: String)
    {
        self.itemID = itemID
        self.itemName = itemName
        self.itemDesc = itemDesc
        self.itemImage = itemImage
        self.itemQuantity = itemQuantity
        self.userID = userID
        self.uniqueID = uniqueID
    }
}
