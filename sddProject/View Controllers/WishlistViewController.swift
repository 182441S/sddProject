//
//  WishlistViewController.swift
//  sddProject
//
//  Created by ITP312Grp2 on 1/7/20.
//  Copyright © 2020 ITP312Grp2. All rights reserved.
//

import UIKit

class WishlistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var itemList: [Item] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadWishlist()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadWishlist()
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
}
