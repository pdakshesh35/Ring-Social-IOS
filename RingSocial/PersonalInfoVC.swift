//
//  SignUpVC.swift
//  RingSocial
//
//  Created by Dakshesh patel on 5/24/17.
//  Copyright © 2017 Dakshesh patel. All rights reserved.
//

import UIKit
import FirebaseAuth
import Alamofire
import FirebaseDatabase

/*
 
 *Call the CameraDelegate to return the image from CameraViewController
 *Fill the both of textfields and the image as profilepic to update the userinformation to Firebase
 *last update the data
 
 */
class PersonalInfoVC: UIViewController, CameraDelegate {

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var imageTapRecognizer: UITapGestureRecognizer!
    @IBOutlet weak var nav_view: UIView!
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var backVC: UIButton!
    @IBOutlet weak var tempImage: UIImageView!
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var username: UITextField!
    
    
    var img : UIImage!
    
    var cameraViewController : CameraViewController!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
       
        CameraViewController.delegate = self
        
        if img != nil {
            
            tempImage.image = img
            tempImage.clipsToBounds = true
            tempImage.contentMode = .scaleAspectFill
            IMAGEVIEW_TEMP = nil
            // UserDefaults.standard.set(nil, forKey: IMAGE_KEY)
        }

    }
    
    //function from CameraDelegate which returns the value from CameraViewController
    func returnImage(image: UIImage) {
        img = image
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialize the CameraDelegate method from Cameraviewcontroller where it was created
        CameraViewController.delegate = self
        
        
       //post image to imageshach
        let user = Auth.auth().currentUser!
        
        
        
        
       

        
        
        
        if img != nil {
            
            tempImage.image = img
            tempImage.clipsToBounds = true
            tempImage.contentMode = .scaleAspectFill
            // UserDefaults.standard.set(nil, forKey: IMAGE_KEY)
        }
       
        UserDefaults.standard.set(user.uid, forKey: SIGNEDIN_KEY)
        bgView.circularControl(cornerRadius: 10)
        
        
        tempImage.addGestureRecognizer(imageTapRecognizer)
        //back button circular view
        
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        print("tapped")

       callForCamera(viewcontroller: self)
        
        //self.performSegue(withIdentifier: "profile", sender: self)
        
        
//
    }
    func tapBlurButton(sender: UITapGestureRecognizer) {
        print("Please Help!")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "profile") {
//            let vc = segue.destination as! CameraViewController
//            let backcamera = vc.getDevice(position: .back)
//            vc.intializeCameraView(backCamera: backcamera!)
        }
    }
    
    
    @IBAction func update(_ sender: Any) {
        
        
        let user = Auth.auth().currentUser!
        let userData = User(name: fullname.text!   , uid: user.uid  , username: username.text!, phonenumber: UserDefaults.standard.value(forKey: PHONENUMBER_KEY) as! String)
        userData.uploadData(viewController: self, profileImage: tempImage.image!)
        
        
        
       
        
         
        
        
    }
    
}
