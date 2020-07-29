//
//  DonationDataManager.swift
//  sddProject
//
//  Created by ITP312Grp2 on 29/7/20.
//  Copyright © 2020 ITP312Grp2. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseFirestoreSwift

class DonationDataManager:NSObject
{
    static let db = Firestore.firestore()
    
    static func loadDonations(onComplete: (([Donation]) -> Void)?) {
        db.collection("donations").getDocuments() {
            (querySnapshot, err) in var donationList : [Donation] = []
            
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    var donation = try? document.data(as: Donation.self) as! Donation
                    
                    if donation != nil {
                        donationList.append(donation!)
                    }
                }
            }
            onComplete?(donationList)
        }
    }
    static func insertOrReplaceDonation(_ donation: Donation)
    {
        try? db.collection("donations")
            .document(donation.donationID)
            .setData(from: donation, encoder: Firestore.Encoder())
            {
                err in
                
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document successfully added!")
                }
            }
        }
    static func deleteDonation(_ donation: Donation)
    {
     
        db.collection("donations").document(donation.donationID).delete() {
            err in
     
            if let err = err {
     
                print("Error removing document: \(err)")
            } else {
     
                print("Document successfully removed!")
    }
     
}
    }
}


