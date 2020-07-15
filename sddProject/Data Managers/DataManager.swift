//
//  DataManager.swift
//  sddProject
//
//  Created by ITP312Grp2 on 6/7/20.
//  Copyright © 2020 ITP312Grp2. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift

class DataManager: NSObject {

    static let db = Firestore.firestore()

    static func loadItems(onComplete: (([Item]) -> Void)?) {
        db.collection("items").getDocuments() {
            (querySnapshot, err) in var itemList : [Item] = []
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    var item = try? document.data(as: Item.self) as! Item
                    
                    if item != nil {
                        itemList.append(item!)
                    }
                }
            }
            onComplete?(itemList)
        }
    }
    
    static func insertOrReplaceItem(_ item: Item) {
        try? db.collection("items").document(item.itemID).setData(from: item, encoder: Firestore.Encoder()) {
            err in if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    static func deleteItem(_ item: Item) {
        db.collection("items").document(item.itemID).delete() {
            err in if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
}
    
//    static func createItemDatabase() {
//        SQLiteDB.sharedInstance.execute(sql:
//            "CREATE TABLE IF NOT EXISTS " + "Items ( " + "itemID text primary key, " + "itemName text, " + "itemDescription text, " + "imagePath text , " + "itemQuantity text )"
//        )
//    }
//    
//    static func loadItems() -> [Item] {
//        let itemRows = SQLiteDB.sharedInstance.query(sql: "SELECT itemID, itemName, " + "itemDescription, imagePath, itemQuantity " + "FROM Items")
//        
//        var items : [Item] = []
//        for row in itemRows {
//            items.append(Item(
////                id: row["itemID"] as! String,
////                name: row["itemName"] as! String,
////                description: row["itemDescription"] as! String,
////                imagePath: row["imagePath"] as! String,
////                quantity: row["itemQuantity"] as! String))
//            
//                row["itemID"] as! String,
//                row["itemName"] as! String,
//                row["itemDescription"] as! String,
//                row["imagePath"] as! String,
//                row["itemQuantity"] as! String))
//        }
//        return items;
//    }
//    
//    static func insertOrReplaceItem(item: Item) {
//        SQLiteDB.sharedInstance.execute(sql: "INSERT OR REPLACE INTO Items (itemID, " + "itemName, itemDescription, imagePath, itemQuantity) " + "VALUES (?, ?, ?, ?, ?) ", parameters: [item.itemID, item.itemName, item.itemDesc, item.itemImage, item.itemQuantity])
//    }
//    
//    static func deleteItem(item: Item) {
//        SQLiteDB.sharedInstance.execute(sql: "DELETE FROM Items WHERE itemID = ?", parameters: [item.itemID])
//    }
//}
