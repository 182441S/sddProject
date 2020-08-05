//
//  RequestDataManager.swift
//  sddProject
//
//  Created by ITP312Grp2 on 29/7/20.
//  Copyright © 2020 ITP312Grp2. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift

class RequestDataManager: NSObject {
    static let db = Firestore.firestore()
    
    static func loadRequests(onComplete: (([RequestedItems]) -> Void)?) {
        db.collection("request").getDocuments() {
            (querySnapshot, err) in
            var requestList : [RequestedItems] = []
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    var request = try? document.data(as: RequestedItems.self) as! RequestedItems
                
                    if request != nil {
                        requestList.append(request!)
                    }
                }
            }
            onComplete?(requestList)
        }
    }
    
    static func insertOrReplaceItem(_ item: RequestedItems) {
        try? db.collection("request").document(item.itemName).setData(from: item, encoder: Firestore.Encoder()) {
            err in if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Item successfully added!")
            }
        }
    }
    
    static func deleteItem(_ item: RequestedItems) {
        db.collection("request").document(item.itemName).delete() {
            err in if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Item Accepted!")
            }
        }
    }
}
