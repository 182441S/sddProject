//
//  RequestInfoViewController.swift
//  sddProject
//
//  Created by ITP312Grp2 on 15/7/20.
//  Copyright © 2020 ITP312Grp2. All rights reserved.
//

import UIKit

class RequestInfoViewController: UIViewController {
    
    @IBOutlet weak var itemName: UITextView!
    @IBOutlet weak var itemCategory: UILabel!
    @IBOutlet weak var itemQuantity: UILabel!
    @IBOutlet weak var itemDesc: UILabel!
    
    var  itemList : RequestedItems?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        itemName.text = itemList?.itemName
        itemCategory.text = itemList?.itemCategory
        itemQuantity.text = itemList?.itemQuantity
        itemDesc.text = itemList?.itemDesc
        
        self.navigationItem.title = itemList?.itemName
    }
    
    @IBAction func acceptButtonPressed(_ sender: Any) {
        
        let alert = UIAlertController (
            title: "Item Request Successfully Accepted!",
            message: "",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        var viewControllers = self.navigationController?.viewControllers
        let parent = viewControllers?[0] as! RequestViewController
        RequestDataManager.deleteItem(itemList!)
        parent.loadRequests()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
