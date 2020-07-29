//
//  RequestViewController.swift
//  sddProject
//
//  Created by ITP312Grp2 on 8/7/20.
//  Copyright © 2020 ITP312Grp2. All rights reserved.
//

import UIKit

class RequestViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var itemList : [RequestedItems] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadRequests()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadRequests()
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let request = itemList[indexPath.row]
            itemList.remove(at: indexPath.row)
            
            RequestDataManager.deleteItem(request)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
