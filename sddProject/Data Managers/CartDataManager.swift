//
//  CartDataManager.swift
//  sddProject
//
//  Created by ITP312Grp2 on 3/8/20.
//  Copyright © 2020 ITP312Grp2. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class CartDataManager: NSObject {
    static let db = Firestore.firestore()
    
    static func loadItems(onComplete: (([Item]) -> Void)?) {
        db.collection("cart").getDocuments() {
            (querySnapshot, err) in var cartList : [Item] = []
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    var item = try? document.data(as: Item.self) as! Item
                    
                    if item != nil {
                        cartList.append(item!)
                    }
                }
            }
            onComplete?(cartList)
        }
    }
    
    static func insertOrReplaceCartItem(_ item: Item)
    {
        try? db.collection("cart").document(item.itemID).setData(from: item, encoder: Firestore.Encoder())
        {
            err in
            
            if let err = err
            {
                print ("Error adding document: \(err)")
            }
            else
            {
                print ("Document successfully added!")
            }
        }
    }
    
    static func deleteCartItem(_ item: Item)
    {
        db.collection("cart").document(item.itemID).delete()
            {
                err in
                
                if let err = err
                {
                    print ("Error removing document: \(err)")
                }
                else
                {
                    print ("Document successfully removed!")
                }
            }
    }
}
