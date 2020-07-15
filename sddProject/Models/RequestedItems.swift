//
//  RequestedItems.swift
//  sddProject
//
//  Created by ITP312Grp2 on 8/7/20.
//  Copyright © 2020 ITP312Grp2. All rights reserved.
//

import UIKit

class RequestedItems: NSObject {
    var itemName: String
    var itemCategory: String
    var itemImage: String
    
    init(_ itemName: String, _ itemCategory: String, _ itemImage: String){
        self.itemName = itemName
        self.itemCategory = itemCategory
        self.itemImage = itemImage
    }
}
