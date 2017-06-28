//
//  User.swift
//  RingSocial
//
//  Created by Dakshesh patel on 6/15/17.
//  Copyright © 2017 Dakshesh patel. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import Firebase
import Alamofire

/*
 *initialize all the necessary fields for the first init
 *intilize firebased -> databasesnapshot to RETRIVE the values
 *PostData with UIImage which is considered as profilePic
    - Alamofire upload image to imageshack with url and key
    - Alamofire retrive the image URL 
    - post that imageURL to postUserData to save the link to firebase
 *PostUserData is post all the data to firebase
 */
class User {
    var name : String
    var uid : String?
    var email : String
    var username : String
    var phonenumber : String?
    var profilePic : String?
    var password : String
    var time   = ServerValue()
    
    
    
    
    init( name : String, email : String, password : String, username : String) {
        
        self.name = name
        self.email = email
        self.username = username.lowercased()
        self.password = password
        
        
    }
    
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: Any]
        self.name = snapshotValue[NAME_KEY_FB] as! String
        self.email = snapshotValue[EMAIL_KEY_FB] as! String
        self.password = snapshotValue[PASSWORD_KEY_FB] as! String
        self.uid = snapshotValue[UID_KEY_FB] as! String
        self.username = snapshotValue[USERNAME_KEY_FB] as! String
        //self.phonenumber = snapshotValue[PHONENUMBER_KEY_FB] as! String
        self.profilePic = snapshotValue[PROFILEPIC_KEY_FB] as! String
       
        
        
    }
    
    //chech first if username exsits or not and if not then
    //upload the image which will redirect to postUserData method
    func uploadData(viewController : UIViewController, profileImage : UIImage) {
       
        
        if self.username.lowercased().characters.count < 5 {
            AlertMessage(title: "Username requirements", message: "Username should be atleast 5 characters long", viewController: viewController)
        } else {
                
                var ref = Database.database().reference()
                ref.child("usernames").observeSingleEvent(of: .value, with: { (snapshot) in
                    if snapshot.hasChild(self.username) {
                        //username already exsits
                        AlertMessage(title: "Username Already exists", message: "Try a unique username with atleast 5 charachter long!", viewController: viewController)
                            return
                    } else {
                        
                         //username does not exsits
                        Auth.auth().createUser(withEmail: self.email, password: self.password) { (user, error) in
                            if(error != nil) {
                                AlertMessage(title: "Sign Up", message: (error?.localizedDescription)!, viewController: viewController)
                                return
                            } else {
                                user?.sendEmailVerification(completion: { (error) in
                                    if (error != nil) {
                                        AlertMessage(title: "Email error", message: (error?.localizedDescription)!, viewController: viewController)
                                        return
                                    }
                                })
                                
                                self.uid = user?.uid
                                self.PostData(image: profileImage)
                                viewController.dismiss(animated: true, completion: nil)

                            }
                        }
                       
                    }
                })
        }
    }
   private func PostData(image : UIImage)  {
        let urlStr = "https://post.imageshack.us/upload_api.php"
        let url = URL(string: urlStr)!
        let imgData = UIImageJPEGRepresentation(image, 0.2)!
        let keyData = "45ABHOQS3027bec417517ee39b850b76efe9a4f3".data(using: .utf8)!  // key removed for sake of privacy
        let keyJSON = "json".data(using: .utf8)!
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imgData, withName: "fileupload", fileName:"image", mimeType: "image/jpg")
            multipartFormData.append(keyData, withName: "key")
            multipartFormData.append(keyJSON, withName: "format")
        }, to: url, encodingCompletion: { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.responseJSON { response in
                    if let info = response.result.value as? [String: AnyObject],
                        let links = info["links"] as? [String: AnyObject],
                        let imgLink = links["image_link"] as? String {
                        //print(imgLink)
                        self.postUserData(imageLink: imgLink)
                    }
                }
            case.failure(_): break
            }
        })
        
    }

    
    private func postUserData(imageLink : String) {
        let post : NSDictionary = [NAME_KEY_FB : self.name,
                                   UID_KEY_FB : self.uid,
                                   USERNAME_KEY_FB : self.username,
                                   EMAIL_KEY_FB : self.email,
                                   PASSWORD_KEY_FB : self.password,
                                   PROFILEPIC_KEY_FB : imageLink,
                                   TIMESTAMP_KEY_FB : ServerValue.timestamp()
                                   ]
        
        var ref = Database.database().reference()
        
        ref.child("User").child(self.uid!).setValue(post)
        ref.child("usernames").child(self.username).setValue(self.uid)
    }
}
