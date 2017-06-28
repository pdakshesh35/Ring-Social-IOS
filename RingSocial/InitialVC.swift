//
//  InitialVC.swift
//  RingSocial
//
//  Created by Dakshesh patel on 6/25/17.
//  Copyright © 2017 Dakshesh patel. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
import Contacts

class InitialVC: UIViewController {

    @IBOutlet weak var camera_switch: UISwitch!
    @IBOutlet weak var contacts_switch: UISwitch!
    @IBOutlet weak var gallary_switch: UISwitch!
    
    
    @IBOutlet weak var startBtn: UIButton!
    
    let cameraAccess = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
    let contactAccess = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        switch cameraAccess {
        case .authorized:
                self.camera_switch.setOn(true, animated: true)
        default:
                self.camera_switch.setOn(false, animated: true)
        }
        
        switch contactAccess {
        case .authorized:
            self.contacts_switch.setOn(true, animated: true)
        default:
            self.contacts_switch.setOn(false, animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startBtn.circularControl(cornerRadius: 5.0)
        
        
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func permissionFOrCamera() {
        AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo) { (response) in
            
            
            if response {
                //access granted
                self.camera_switch.setOn(true, animated: true)
            } else {
                self.camera_switch.setOn(false, animated: true)
                AlertMessage(title: "Privacy Setting", message: "It looks like your privacy settings are preventing us from accessing your camera for this Application. You can fix this by doing the following:\n\n1. Close this app.\n\n2. Open the Settings app.\n\n3. Scroll to the bottom and select this app in the list.\n\n4. Touch Privacy.\n\n5. Turn the Camera on.\n\n6. Open this app and try again. ", viewController: self)
                
            }
            
            
        }

    }
   
    @IBAction func camera(_ sender: Any) {
        
        switch cameraAccess {
        case .authorized:
               self.camera_switch.setOn(true, animated: true)
        case .denied :
                 AlertMessage(title: "Privacy Setting", message: "It looks like your privacy settings are preventing us from accessing your camera for this Application. You can fix this by doing the following:\n\n1. Close this app.\n\n2. Open the Settings app.\n\n3. Scroll to the bottom and select this app in the list.\n\n4. Touch Privacy.\n\n5. Turn the Camera on.\n\n6. Open this app and try again. ", viewController: self)
                self.camera_switch.setOn(false, animated: true)
            
        case .notDetermined :
             self.camera_switch.setOn(false, animated : true)
                permissionFOrCamera()
        default:
            self.camera_switch.setOn(false, animated : true)
                permissionFOrCamera()
        }
        
       
          }
    
    func permissionForContact() {
        let access = CNContactStore()
        access.requestAccess(for: CNEntityType.contacts) { (isGranted, error) in
            if error != nil {
                AlertMessage(title: "Privacy Setting", message: "It looks like your privacy settings are preventing us from accessing your Contacts for this Application. You can fix this by doing the following:\n\n1. Close this app.\n\n2. Open the Settings app.\n\n3. Scroll to the bottom and select this app in the list.\n\n4. Touch Privacy.\n\n5. Turn the Contacts on.\n\n6. Open this app and try again. ", viewController: self)
                self.contacts_switch.setOn(false, animated : true)
                
                
                
            } else {
                
                self.contacts_switch.setOn(true, animated : true)
            }
            
            
            
        }
    }
    @IBAction func Contacts(_ sender: UISwitch) {
        switch contactAccess {
        case .authorized:
            self.contacts_switch.setOn(true, animated: true)
        case .denied :
            
            AlertMessage(title: "Privacy Setting", message: "It looks like your privacy settings are preventing us from accessing your Contacts for this Application. You can fix this by doing the following:\n\n1. Close this app.\n\n2. Open the Settings app.\n\n3. Scroll to the bottom and select this app in the list.\n\n4. Touch Privacy.\n\n5. Turn the Contacts on.\n\n6. Open this app and try again. ", viewController: self)
            self.contacts_switch.setOn(false, animated: true)
        case .notDetermined :
            self.contacts_switch.setOn(false, animated : true)
            permissionForContact()
        default:
            self.contacts_switch.setOn(false, animated : true)
            permissionForContact()
        }
    }
    
    
    @IBAction func Gallary(_ sender: UISwitch) {
        
        
    }
    
    
    @IBAction func start(_ sender: Any) {
        
        if self.camera_switch.isOn && self.contacts_switch.isOn {
            self.performSegue(withIdentifier: "InitialToVC", sender: self)
        } else {
            AlertMessage(title: "Access Tools", message: "Make sure both of the switch are on, and then Try to start!", viewController: self)
        }
    }
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
