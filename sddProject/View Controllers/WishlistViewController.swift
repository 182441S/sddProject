//
//  WishlistViewController.swift
//  sddProject
//
//  Created by ITP312Grp2 on 1/7/20.
//  Copyright © 2020 ITP312Grp2. All rights reserved.
//

import UIKit
import FirebaseAuth

class WishlistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var itemList: [WishlistItem] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            self.navigationItem.leftBarButtonItem?.isEnabled = true
            self.navigationItem.leftBarButtonItem?.tintColor = .systemOrange
            
            self.label.isHidden = true
            
            self.tableView.isHidden = false
            
            loadWishlist()
        }
        else {
            self.navigationItem.leftBarButtonItem?.isEnabled = false
            self.navigationItem.leftBarButtonItem?.tintColor = .systemBackground
            
            self.tableView.isHidden = true
            
            self.label.isHidden = false
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        
        self.tableView.isHidden = true
    }
    
    func loadWishlist()
    {
        WishlistDataManager.loadWishlist ()
            {
                wishlistListFromFirestore in
                
                self.itemList = wishlistListFromFirestore
                
                self.tableView.reloadData()
            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemTableViewCell
        
        let p = itemList[indexPath.row]
        
        cell.itemNameLabel.text = p.itemName
        cell.itemImageView.image = UIImage(named: p.itemImage)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ShowWishlistDetails")
        {
            let detailViewController = segue.destination as! WishlistDetailViewController
            let myIndexPath = self.tableView.indexPathForSelectedRow
            
            if(myIndexPath != nil)
            {
                let item = itemList[myIndexPath!.row]
                detailViewController.item = item
            }
        }
    }
    
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            
            self.navigationItem.leftBarButtonItem?.isEnabled = false
            self.navigationItem.leftBarButtonItem?.tintColor = .systemBackground
            
            self.tableView.isHidden = true
            
            self.label.isHidden = false
        }
        
        catch let err as NSError {
            print("Cannot sign %@ out leh...", err)
        }
    }
}
