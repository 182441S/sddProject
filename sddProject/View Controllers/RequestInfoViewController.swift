//
//  RequestInfoViewController.swift
//  sddProject
//
//  Created by ITP312Grp2 on 15/7/20.
//  Copyright © 2020 ITP312Grp2. All rights reserved.
//

import UIKit

class RequestInfoViewController: UIViewController {

    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemCategory: UILabel!
    @IBOutlet weak var itemDesc: UILabel!
    
    var  itemList : RequestedItems?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        itemName.text = itemList?.itemName
        itemCategory.text = itemList?.itemCategory
        itemDesc.text = itemList?.itemDesc
        
        self.navigationItem.title = itemList?.itemName
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
