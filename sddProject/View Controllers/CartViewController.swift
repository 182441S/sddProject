//
//  CartViewController.swift
//  sddProject
//
//  Created by ITP312Grp2 on 3/8/20.
//  Copyright © 2020 ITP312Grp2. All rights reserved.
//

import UIKit
import FirebaseAuth

class CartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var cartList: [Item] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            self.navigationItem.leftBarButtonItem?.isEnabled = true
            self.navigationItem.leftBarButtonItem?.tintColor = .systemOrange
            
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            self.navigationItem.rightBarButtonItem?.tintColor = .systemOrange
            
            self.label.isHidden = true
            
            self.tableView.isHidden = false
            
            loadCart()
        }
        else {
            self.navigationItem.leftBarButtonItem?.isEnabled = false
            self.navigationItem.leftBarButtonItem?.tintColor = .systemBackground
            
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            self.navigationItem.rightBarButtonItem?.tintColor = .systemBackground
            
            self.tableView.isHidden = true
            
            self.label.isHidden = false
        }
    }
    
    func loadCart()
    {
        CartDataManager.loadItems()
            {
                cartListFromFirestore in
                
                self.cartList = cartListFromFirestore
                
                if self.cartList.isEmpty {
                    self.tableView.isHidden = true
                    
                    self.label.isHidden = false
                }
                else {
                    self.label.isHidden = true
                    
                    self.tableView.isHidden = false
                    
                    self.tableView.reloadData()
                }
            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CartTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CartCell", for: indexPath) as! CartTableViewCell
        
        let p = cartList[indexPath.row]
        
        cell.itemNameLabel.text = p.itemName
        cell.itemQtyLabel.text = "Quantity: " + p.itemQuantity
        cell.itemImageView.image = UIImage(named: p.itemImage)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let remove = UITableViewRowAction(style: .destructive, title: "Remove") {
            (action, indexPath) in
            let item = self.cartList[indexPath.row]
            
            let alertController = UIAlertController(title: "Confirm", message: "Are you sure you want to remove this item from your cart?", preferredStyle: .alert)
            
            let confirm: UIAlertAction = UIAlertAction(title: "OK", style: .default)
            { action -> Void in
                CartDataManager.deleteCartItem(item)
                
                self.loadCart()
            }
            
            let cancel: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel)
            
            alertController.addAction(confirm)
            
            alertController.addAction(cancel)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        remove.backgroundColor = UIColor.red
        
        return [remove]
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            
            self.navigationItem.leftBarButtonItem?.isEnabled = false
            self.navigationItem.leftBarButtonItem?.tintColor = .systemBackground
            
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            self.navigationItem.rightBarButtonItem?.tintColor = .systemBackground
            
            self.tableView.isHidden = true
            
            self.label.isHidden = false
            
            let alertController = UIAlertController(title: nil, message: "You have logged out successfully.", preferredStyle: .alert)
            
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .default)
            
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        catch let err as NSError {
            print("Cannot sign %@ out leh...", err)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
