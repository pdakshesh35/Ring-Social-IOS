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
import AVFoundation
/*
 
 */

class ViewController: UIViewController {

   
    
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var areaCode: UILabel!
   
    @IBOutlet weak var phonenumber: UITextField!
    
    @IBOutlet weak var verification_code: UITextField!
    
    @IBOutlet weak var logInView: UIButton!
    
    @IBOutlet weak var signUpView: UIButton!
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
    
    
    
    @IBAction func login(_ sender: Any) {
        
        if(emailField.text == "" || passwordField.text == "") {
            AlertMessage(title: "Filds are Empty", message: "Please fill up all the fields", viewController: self)
        } else {
            Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!) { (user, error) in
                if error != nil {
                    AlertMessage(title: "Login Error", message: (error?.localizedDescription)!, viewController: self)
                    return
                } else if (!(user?.isEmailVerified)!) {
                    AlertMessage(title: "Email Verification Failed", message: "Please verify your email, and then try again to sign in", viewController: self)
                } else {
                    //user signed in
                    UserDefaults.standard.set(user?.uid, forKey: SIGNEDIN_KEY)
                    self.performSegue(withIdentifier: SEGUE_VIEW_MAIN, sender: self)
                }
            }
        }
    }
    
    
    @IBAction func signUP(_ sender: Any) {
        if(emailField.text == "" || passwordField.text == "") {
            AlertMessage(title: "Filds are Empty", message: "Please fill up all the fields", viewController: self)
        } else {
            self.performSegue(withIdentifier: SEGUE_MAIN_SIGNUP, sender: self)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SEGUE_MAIN_SIGNUP {
            let vc = segue.destination as! PersonalInfoVC
            vc.emailId = emailField.text
            vc.password = passwordField.text
        }
    }
    //customize view
    func interface() {
        //email view
        emailView.CircularViewWithBorders(cornerRadius: 10, borderWidth: 2.0)
        
        //placeholder text color
        emailField.attributedPlaceholder = NSAttributedString(string: "Email..",
                                                              attributes: [NSForegroundColorAttributeName: UIColor.white])
        //password view
        passwordView.CircularViewWithBorders(cornerRadius: 10, borderWidth: 2.0)
        
        //placeholder text color
        passwordField.attributedPlaceholder = NSAttributedString(string: "Password",
                                                                 attributes: [NSForegroundColorAttributeName: UIColor.white])
        
        
        //button views
        logInView.circularControl(cornerRadius: 7.0)
        signUpView.circularControl(cornerRadius: 7.0)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interface()
        
               
        
        let profile = DeviceProfile()
        profile.initialization()
        //areaCode.text = COUNTRY_CODE
        
                // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func circularContril(cornerRadius : Int)  {
        
    }
   


}

