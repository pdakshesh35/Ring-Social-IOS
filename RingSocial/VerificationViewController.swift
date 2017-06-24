//
//  VerificationViewController.swift
//  RingSocial
//
//  Created by Dakshesh patel on 6/16/17.
//  Copyright © 2017 Dakshesh patel. All rights reserved.
//

import UIKit
import Foundation
import FirebaseAuth
class VerificationViewController: UIViewController {

    
    
    @IBOutlet weak var verification_code: UITextField!
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resend(_ sender: Any) {
        PhoneAuthProvider.provider().verifyPhoneNumber(UserDefaults.standard.value(forKey: PHONENUMBER_KEY) as! String) { (verificationID, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            } else {
                print("successfully sent")
                UserDefaults.standard.set(verificationID, forKey: VERIFICATIONID_KEY)
                
                
            }
        }
    }
    
    
    @IBAction func verifycode(_ sender: Any) {
        
        let verificationId = UserDefaults.standard.value(forKey: VERIFICATIONID_KEY)
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationId as! String,
            verificationCode: verification_code.text!)
        
        Auth.auth().signIn(with: credential) { (user, error) in
            
            if let error = error {
                
                AlertMessage(title: "Verification Code", message: error.localizedDescription, viewController: self)
                
                return
            }
            
            self.performSegue(withIdentifier: SEGUE_VERIFY_PERSONAL, sender: self)
            
            
            // User is signed in
            
            
        }
        

    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  }
