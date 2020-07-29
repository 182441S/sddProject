//
//  WishlistDataManager.swift
//  sddProject
//
//  Created by ITP312Grp2 on 15/7/20.
//  Copyright © 2020 ITP312Grp2. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseAuth

class WishlistDataManager: NSObject {
    static let db = Firestore.firestore()
    
    static func loadWishlist(onComplete: (([WishlistItem]) -> Void)?)
    {
        db.collection("wishlist").getDocuments()
            {
                (querySnapshot, err) in
                    
                var wishlistList : [WishlistItem] = []
                
                if let err = err
                {
                    print ("Error getting documents: \(err)")
                }
                else
                {
                    var user = Auth.auth().currentUser?.email
                    
                    for document in querySnapshot!.documents
                    {
                        var item = try? document.data(as: WishlistItem.self) as! WishlistItem
                        
                        if item != nil
                        {
                            if item?.userID == user {
                                wishlistList.append(item!)
                            }
                        }
                    }
                }
                
                onComplete?(wishlistList)
            }
    }
    
    static func insertOrReplaceWishlistItem(_ item: WishlistItem)
    {
        try? db.collection("wishlist").document(item.itemID).setData(from: item, encoder: Firestore.Encoder())
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
    
    static func deleteWishlistItem(_ item: WishlistItem)
    {
        db.collection("wishlist").document(item.itemID).delete()
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
