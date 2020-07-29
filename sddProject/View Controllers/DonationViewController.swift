//
//  DonationViewController.swift
//  sddProject
//
//  Created by ITP312Grp2 on 29/6/20.
//  Copyright © 2020 ITP312Grp2. All rights reserved.
//
import UIKit


class DonationViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var donationList: [Donation] = []
    
    
    @IBOutlet weak var ItemInput: UITextField!
    @IBOutlet weak var takePicture: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var DonationTable: UITableView!
    
    @IBAction func AddDonation(_ sender: UIButton) {
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDonations()
        
    // Do any additional setup after loading the view, // typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func takePicturePressed(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        // Setting this to true allows the user to crop and scale // the image to a square after the photo is taken.
        //
        picker.allowsEditing = true
        picker.sourceType = .camera
        
        self.present(picker, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info:
        [UIImagePickerController.InfoKey : Any])
    {
        let chosenImage : UIImage =
            info[.editedImage] as! UIImage
        self.imageView!.image = chosenImage
    // This saves the image selected / shot by the user
    //
        UIImageWriteToSavedPhotosAlbum(chosenImage, nil, nil, nil)
    // This closes the picker
    //
        picker.dismiss(animated: true)
    }
    func imagePickerControllerDidCancel(
    _ picker: UIImagePickerController)
    {
    picker.dismiss(animated: true)
    }
    func Donationtable(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return donationList.count
    }
    
    
    
    func loadDonations()
    {
    
    DonationDataManager.loadDonations () {
    donationListFromFirestore in
    
    self.donationList = donationListFromFirestore
    
    self.DonationTable.reloadData()
    }
}
    
    
}

 

