//
//  WishlistDetailViewController.swift
//  sddProject
//
//  Created by ITP312Grp2 on 13/7/20.
//  Copyright © 2020 ITP312Grp2. All rights reserved.
//

import UIKit

class WishlistDetailViewController: UIViewController {

    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemDescLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    
    var item : WishlistItem?
    
    @IBAction func redeemButtonPressed(_ sender: Any) {
    }
    
    
    @IBAction func removeButtonPressed(_ sender: Any) {
        let alertController = UIAlertController(title: "Confirm", message: "Are you sure you want to remove this item from your wishlist?", preferredStyle: .alert)
        
        let remove: UIAlertAction = UIAlertAction(title: "OK", style: .default)
        { action -> Void in
            let viewControllers = self.navigationController?.viewControllers
            
            let parent = viewControllers?[0] as! WishlistViewController
            
            WishlistDataManager.deleteWishlistItem(self.item!)
            
            parent.loadWishlist()
            
            self.navigationController?.popViewController(animated: true)
        }
        
        let cancel: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(remove)
        
        alertController.addAction(cancel)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        itemNameLabel.text = item?.itemName
        itemDescLabel.text = item?.itemDesc
        itemImageView.image = UIImage(named: (item?.itemImage)!)
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
