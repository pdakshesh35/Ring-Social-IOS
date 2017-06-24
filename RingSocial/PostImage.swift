//
//  PostImage.swift
//  RingSocial
//
//  Created by Dakshesh patel on 6/20/17.
//  Copyright © 2017 Dakshesh patel. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class PostImage {
    var imgLink : String
    var image : UIImage
    var viewController : UIViewController
    
    init(image : UIImage, viewController : UIViewController) {
       
        self.image = image
        self.viewController = viewController
        self.imgLink = ""
    }
    
        
    func PostImage()  {
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
                        self.setImageLink(link: imgLink)
                    }
                }
            case.failure(_): break
            }
        })

    }

    func setImageLink(link : String)  {
        self.imgLink = link
    }
    func getImageLink() -> String {
        return self.imgLink
    }
    
    
}
