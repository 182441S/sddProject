//
//  RequestViewController.swift
//  sddProject
//
//  Created by ITP312Grp2 on 8/7/20.
//  Copyright © 2020 ITP312Grp2. All rights reserved.
//

import UIKit
import FirebaseAuth

class RequestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var requestButton: UIButton!
    @IBOutlet weak var label: UILabel!
    
    var itemList : [RequestedItems] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadRequests()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            
            self.navigationItem.leftBarButtonItem?.isEnabled = true
            self.navigationItem.leftBarButtonItem?.tintColor = .systemOrange
            
            self.navigationItem.rightBarButtonItem?.isEnabled = true
            self.navigationItem.rightBarButtonItem?.tintColor = .systemOrange
            
            self.tableView.isHidden = false
            self.requestButton.isHidden = false
            self.label.isHidden = true
            
            loadRequests()
        }
        else {
            self.navigationItem.leftBarButtonItem?.isEnabled = false
            self.navigationItem.leftBarButtonItem?.tintColor = .systemBackground
            
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            self.navigationItem.rightBarButtonItem?.tintColor = .systemBackground
            
            self.tableView.isHidden = true
            self.requestButton.isHidden = true
            self.label.isHidden = false
        }
    }
    
    func loadRequests()
    {
        RequestDataManager.loadRequests()
            {
                requestListFromFirestore in
                self.itemList = requestListFromFirestore
                self.tableView.reloadData()
            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! RequestItemCell
        
        tableView.rowHeight = 114
        
        let p = itemList[indexPath.row]
        
        cell.itemName.text = p.itemName
        cell.itemCategory.text = p.itemCategory
        cell.itemQuantity.text = p.itemQuantity
        
        return cell
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowItemInfo"){
            let RequestInfoViewController = segue.destination as! RequestInfoViewController
            
            let myIndexPath = self.tableView.indexPathForSelectedRow
            
            if(myIndexPath != nil){
                let items = itemList[myIndexPath!.row]
                RequestInfoViewController.itemList = items
            }
        }
        
        if (segue.identifier == "RequestForItem"){
            let RequestItemViewController = segue.destination as! RequestItemViewController
            let item = RequestedItems("", "", "", "")
            RequestItemViewController.item = item
        }
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.tableView.isHidden = true
            self.requestButton.isHidden = true
            self.label.isHidden = false
            self.navigationItem.leftBarButtonItem?.isEnabled = false
            self.navigationItem.rightBarButtonItem?.isEnabled = false
            
            let alert = UIAlertController (
                title: "Successfully Logged Out!",
                message: "",
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        catch let err as NSError {
            print("Error signing out!", err)
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
