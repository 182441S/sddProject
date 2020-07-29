//
//  RequestedItems.swift
//  sddProject
//
//  Created by ITP312Grp2 on 8/7/20.
//  Copyright © 2020 ITP312Grp2. All rights reserved.
//

import UIKit

class RequestedItems: Codable {
    
    var itemName: String
    var itemCategory: String
    var itemDesc: String
    var itemQuantity: String
    
    init(_ itemName: String, _ itemCategory: String, _ itemDesc: String, _ itemQuantity: String)
    {
        self.itemName = itemName
        self.itemCategory = itemCategory
        self.itemDesc = itemDesc
        self.itemQuantity = itemQuantity
    }
}
