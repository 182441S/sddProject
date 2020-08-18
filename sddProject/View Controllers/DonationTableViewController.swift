//
//  DonationTableViewController.swift
//  sddProject
//
//  Created by 183082T  on 8/17/20.
//  Copyright © 2020 ITP312Grp2. All rights reserved.
//

import UIKit
import FirebaseAuth

class DonationTableViewController: UIViewController {
    
    
    
    
    
    var donationlist: [Donation] = []
    
   
    
    
    
    
    
    @IBOutlet var tableView: UITableView!
    
    
    
    

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    // Do any additional setup after loading the view, // typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            self.navigationItem.leftBarButtonItem?.isEnabled = true
            self.navigationItem.leftBarButtonItem?.tintColor = .systemOrange
            
            
            
            self.tableView.isHidden = false
            
            loadDonations()
        }
        else {
            self.navigationItem.leftBarButtonItem?.isEnabled = false
            self.navigationItem.leftBarButtonItem?.tintColor = .systemBackground
            
            self.tableView.isHidden = true
            
            
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        
        self.tableView.isHidden = true
    }
    
    func loadDonations()
    {
        DonationDataManager.loadDonations ()
            {
                donationListFromFirestore in
                
                self.donationlist = donationListFromFirestore
                
                if self.donationlist.isEmpty {
                    self.tableView.isHidden = true
                    
                    
                }
                else {
                    
                    
                    self.tableView.isHidden = false
                    
                    self.tableView.reloadData()
                }
            }
    }
    
    func tableView(_ tableview: UITableView, numberOfRowsInSection section: Int) -> Int {
        return donationlist.count
    }
    
    func tableView(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DonationTableViewCell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DonationTableViewCell
        
        let p = donationlist[indexPath.row]
        
        cell.donationName.text = p.donationName
        cell.donationImage.image = UIImage(named: p.donationImage)
        cell.donationQuantity.text=p.donationQuantity
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ShowDonationDetails")
        {
            let detailViewController = segue.destination as! DonationViewController
            let myIndexPath = self.tableView.indexPathForSelectedRow
            
            if(myIndexPath != nil)
            {
                let donation = donationlist[myIndexPath!.row]
                detailViewController.donation = donation
            }
        }
    }
    
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            
            self.navigationItem.leftBarButtonItem?.isEnabled = false
            self.navigationItem.leftBarButtonItem?.tintColor = .systemBackground
            
            self.tableView.isHidden = true
            
            
            let alertController = UIAlertController(title: nil, message: "You have logged out successfully.", preferredStyle: .alert)
            
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .default)
            
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        catch let err as NSError {
            print("Cannot sign %@ out leh...", err)
        }
    }
    
    
}

