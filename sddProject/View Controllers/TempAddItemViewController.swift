//
//  TempAddItemViewController.swift
//  sddProject
//
//  Created by ITP312Grp2 on 13/7/20.
//  Copyright © 2020 ITP312Grp2. All rights reserved.
//

import UIKit

class TempAddItemViewController: UIViewController {
    @IBOutlet weak var itemID: UITextField!
    @IBOutlet weak var imagePath: UITextField!
    @IBOutlet weak var itemName: UITextField!
    @IBOutlet weak var itemDesc: UITextField!
    @IBOutlet weak var itemQuantity: UITextField!
    
    
    @IBAction func savePressed(_ sender: Any) {
        if itemID.text == "" || imagePath.text == "" || itemName.text == "" || itemDesc.text == "" || itemQuantity.text == "" {
            let alert = UIAlertController (
                title: "Please Enter All Fields",
                message: "",
                preferredStyle: .alert
            )
            
            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
            return
        }
        
        item!.itemID = itemID.text!
        item!.itemImage = imagePath.text!
        item!.itemName = itemName.text!
        item!.itemDesc = itemDesc.text!
        item!.itemQuantity = itemQuantity.text!
        
        DataManager.insertOrReplaceItem(item!)
        
        let viewControllers = self.navigationController?.viewControllers
        let parent = viewControllers?[0] as! LandingPageViewController
        DataManager.insertOrReplaceItem(item!)
        parent.loadItems()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    var item : Item?
    
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
