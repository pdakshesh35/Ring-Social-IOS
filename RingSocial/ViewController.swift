//
//  ViewController.swift
//  RingSocial
//
//  Created by Dakshesh patel on 5/24/17.
//  Copyright © 2017 Dakshesh patel. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseMessaging

/*
 
 */

class ViewController: UIViewController {

    @IBOutlet weak var areaCode: UILabel!
   
    @IBOutlet weak var phonenumber: UITextField!
    
    @IBOutlet weak var verification_code: UITextField!
    
    
    @IBAction func sendVerification(_ sender: Any) {
        
        var phoneCharachterCount = phonenumber.text!.characters.count
        
        if(phoneCharachterCount == 10){
        
        
        PhoneAuthProvider.provider().verifyPhoneNumber(COUNTRY_CODE + phonenumber.text!) { (verificationID, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            } else {
                print("successfully sent")
                UserDefaults.standard.set(verificationID, forKey: VERIFICATIONID_KEY)
                UserDefaults.standard.set(COUNTRY_CODE + self.phonenumber.text!, forKey: PHONENUMBER_KEY)
                
                self.performSegue(withIdentifier: SEGUE_VIEWCONTROLLER_VERIFICATION, sender: self)
                
            }
            
            // Sign in using the verificationID ands the code sent to the user
            // ...
        }
        } else {
            AlertMessage(title: "Phone Number", message: "Please Reverify the Phone Number", viewController: self)
        }
    }
    
    
    @IBAction func verifyCode(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        areaCode.text = COUNTRY_CODE
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func circularContril(cornerRadius : Int)  {
        
    }
   


}

