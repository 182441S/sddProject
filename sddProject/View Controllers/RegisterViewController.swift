//
//  RegisterViewController.swift
//  sddProject
//
//  Created by ITP312Grp2 on 22/7/20.
//  Copyright © 2020 ITP312Grp2. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerAction(_ sender: Any) {
        
        let home = LandingPageViewController()
        
        if password.text != confirmPassword.text {
            
            let alertController = UIAlertController(title: "Password Invalid", message: "Please ensure both passwords are the same", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        else {
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) {
                
                (user, err) in
                
                if err == nil {
                    self.present(home, animated: true, completion: nil)
                }
                
                else {
                    let alertController = UIAlertController(title: "Error?@$!", message: err?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
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
