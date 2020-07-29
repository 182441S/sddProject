//
//  RequestItemViewController.swift
//  sddProject
//
//  Created by ITP312Grp2 on 13/7/20.
//  Copyright © 2020 ITP312Grp2. All rights reserved.
//

import UIKit

class RequestItemViewController: UIViewController {
    
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var itemDesc: UITextField!
    @IBOutlet weak var itemCategory: UITextField!
    @IBOutlet weak var itemQuantity: UITextField!
        
    @IBAction func requestButton(_ sender: Any) {
        if itemName.text == "" || itemDesc.text == "" || itemCategory.text == "" || itemQuantity.text == "" {
            let alert = UIAlertController (
                title: "Please Enter All Fields",
                message: "",
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        item!.itemName = itemName.text!
        item!.itemDesc = itemDesc.text!
        item!.itemCategory = itemCategory.text!
        item!.itemQuantity = itemQuantity.text!
        
        RequestDataManager.insertOrReplaceItem(item!)
        
        let viewControllers = self.navigationController?.viewControllers
        let parent = viewControllers?[0] as! RequestViewController
        RequestDataManager.insertOrReplaceItem(item!)
        parent.loadRequests()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    var item : RequestedItems?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}
