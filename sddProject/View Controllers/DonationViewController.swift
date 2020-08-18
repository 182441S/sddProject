//
//  DonationViewController.swift
//  sddProject
//
//  Created by ITP312Grp2 on 29/6/20.
//  Copyright © 2020 ITP312Grp2. All rights reserved.
//
import UIKit
import FirebaseAuth

class DonationViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var donation: Donation?
    
    var donationList = Donation("", "", "", "");
    
    
    
    @IBOutlet weak var QuantityInput: UITextField!
    
    @IBOutlet weak var takePicture: UIButton!
   
   
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var ItemInput: UITextField!
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    // Do any additional setup after loading the view, // typically from a nib.
    }
    
    @IBAction func AddDonation(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            let alertController = UIAlertController(title: "Success!", message: "Item added to list successfully.", preferredStyle: .alert)
            
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .default)
            { action -> Void in
               self.donationList.donationName = self.donation!.donationName
                self.donationList.donationQuantity = self.donation!.donationQuantity
                self.donationList.donationID = self.donation!.donationID
                self.donationList.donationImage = self.donation!.donationImage
                DonationDataManager.insertOrReplaceDonation(self.donationList)
                
                self.navigationController?.popViewController(animated: true)
            }
            
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            let alertController = UIAlertController(title: "Error!", message: "You are not logged in.", preferredStyle: .alert)
            
            let defaultAction: UIAlertAction = UIAlertAction(title: "OK", style: .cancel)
            { action -> Void in
                self.navigationController?.popToRootViewController(animated: true)
            }
            
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func Takepicturebutton(_ sender: Any) {
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
    
    

    
    
}

 

