//
//  Message.swift
//  RingSocial
//
//  Created by Dakshesh patel on 6/23/17.
//  Copyright © 2017 Dakshesh patel. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import Alamofire

enum Type : String{
    case TEXT = "text"
    case IMAGE = "image"
    
}
class Message {
    var from : String
    var type : String
    var message : String
    var time : String
    var to : String
    var image : UIImage?
    
    init(from : String, type : Type, message : String, time : String, to : String) {
        
        self.from = from
        self.type = type.rawValue
        self.message = message
        self.time = time
        self.to = to
    }
    
    
    init(snapshot : DataSnapshot) {
        let snapshotValue = snapshot.value as! [String: Any]
        self.from = snapshotValue[FROM_KEY_FB] as! String
        self.type = snapshotValue[TYPE_KEY_FB] as! String
        self.message = snapshotValue[MESSAGE_KEY_FB] as! String
        self.to = snapshotValue[TO_KEY_FB] as! String
        self.time = snapshotValue[TIMESTAMP_KEY_FB] as! String
        
        
    }
    
     func PostData(image : UIImage)  {
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
                        self.postMessages(image: image)
                    }
                }
            case.failure(_): break
            }
        })
        
    }
    
    private func postMessages(image : UIImage) {
        let post : NSDictionary = [FROM_KEY_FB : self.from,
                                   TYPE_KEY_FB : self.type,
                                   MESSAGE_KEY_FB : self.message,
                                   TO_KEY_FB : self.to
                                ]
        
        
        var ref = Database.database().reference()
        ref.child("Message").childByAutoId().setValue(post)
    }
    

    
}
