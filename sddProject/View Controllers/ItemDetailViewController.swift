//
//  ItemDetailViewController.swift
//  sddProject
//
//  Created by ITP312Grp2 on 6/7/20.
//  Copyright © 2020 ITP312Grp2. All rights reserved.
//

import UIKit
import FirebaseAuth

class ItemDetailViewController: UIViewController {

    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemDescription: UITextView!
    @IBOutlet weak var itemQuantity: UILabel!
    
    var item : Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if item != nil {
            itemName.text = item!.itemName
            itemDescription.text = item!.itemDesc
            itemQuantity.text = item!.itemQuantity
            itemImage.image = UIImage(named: (item!.itemImage))
        }
        
        self.navigationItem.title = item?.itemName
    }
    
    @IBAction func addToCartPressed(_ sender: Any) {
        if Auth.auth().currentUser == nil {
            let alertController = UIAlertController(title: "Error!", message: "Please log in.", preferredStyle: .alert)
            
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel)
            { action -> Void in
                self.navigationController?.popViewController(animated: true)
            }
            
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            let alertController = UIAlertController(title: "Success!", message: "Item added to cart successfully.", preferredStyle: .alert)
            
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .default)
            { action -> Void in
                self.item?.itemQuantity = "1"
                
                CartDataManager.insertOrReplaceCartItem(self.item!)
                
                self.navigationController?.popViewController(animated: true)
            }
            
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

