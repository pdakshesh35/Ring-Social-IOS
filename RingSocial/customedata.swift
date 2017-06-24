//
//  customedata.swift
//  RingSocial
//
//  Created by Dakshesh patel on 5/26/17.
//  Copyright © 2017 Dakshesh patel. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


//storyboard id
var STORYBOARD_CAMERAVC = "cameraVC"
var STORYBOARD_SNAPVC = "SnapVC"
var STORYBOARD_CHATVC = "ChatViewController"
var STORYBOARD_MAINVC = "MainVC"

//Defults static variable
var IMAGEVIEW_TEMP : UIImage?

//Cell identifiers
var IDENTIFIERS_FILTER_CELL = "filterCellXib"
var IDENTIFIERS_SNAP_CELL = "SnapCell"
var IDENTIFIERS_CHAT_CELL = "ChatCell"
var IDENTIFIERS_CHAT_STORY_CELL = "ChatStoryViewCell"
var IDENTIFIERS_USER_CELL = "UserCell"


//Userdefaults keys
var SIGNEDIN_KEY = "signin"
var PROFILEINFO_KEY = "profileinfo"
var VERIFICATIONID_KEY = "authVerificationID"
var PHONENUMBER_KEY = "phonenumber"
var IMAGE_KEY = "tempimage"


//SegueIdentifiers
var SEGUE_VIEWCONTROLLER_VERIFICATION = "ViewToVerification"
var SEGUE_VERIFY_PERSONAL = "VerifyToPersonalInfo"
var SEGUE_PERSONAL_MAIN = "PersonalToMain"


//FirebaseKeys
var UID_KEY_FB = "uid"
var NAME_KEY_FB = "name"
var USERNAME_KEY_FB = "username"
var PROFILEPIC_KEY_FB = "profilePic"
var PHONENUMBER_KEY_FB = "phonenumber"
var TIMESTAMP_KEY_FB = "timestamp"
var FROM_KEY_FB = "from"
var TYPE_KEY_FB = "type"
var MESSAGE_KEY_FB = "message"
var TO_KEY_FB = "to"

//Country Code
 func getCountryPhonceCode (_ country : String) -> String
{
    var countryDictionary  = ["AF":"93",
                              "AL":"355",
                              "DZ":"213",
                              "AS":"1",
                              "AD":"376",
                              "AO":"244",
                              "AI":"1",
                              "AG":"1",
                              "AR":"54",
                              "AM":"374",
                              "AW":"297",
                              "AU":"61",
                              "AT":"43",
                              "AZ":"994",
                              "BS":"1",
                              "BH":"973",
                              "BD":"880",
                              "BB":"1",
                              "BY":"375",
                              "BE":"32",
                              "BZ":"501",
                              "BJ":"229",
                              "BM":"1",
                              "BT":"975",
                              "BA":"387",
                              "BW":"267",
                              "BR":"55",
                              "IO":"246",
                              "BG":"359",
                              "BF":"226",
                              "BI":"257",
                              "KH":"855",
                              "CM":"237",
                              "CA":"1",
                              "CV":"238",
                              "KY":"345",
                              "CF":"236",
                              "TD":"235",
                              "CL":"56",
                              "CN":"86",
                              "CX":"61",
                              "CO":"57",
                              "KM":"269",
                              "CG":"242",
                              "CK":"682",
                              "CR":"506",
                              "HR":"385",
                              "CU":"53",
                              "CY":"537",
                              "CZ":"420",
                              "DK":"45",
                              "DJ":"253",
                              "DM":"1",
                              "DO":"1",
                              "EC":"593",
                              "EG":"20",
                              "SV":"503",
                              "GQ":"240",
                              "ER":"291",
                              "EE":"372",
                              "ET":"251",
                              "FO":"298",
                              "FJ":"679",
                              "FI":"358",
                              "FR":"33",
                              "GF":"594",
                              "PF":"689",
                              "GA":"241",
                              "GM":"220",
                              "GE":"995",
                              "DE":"49",
                              "GH":"233",
                              "GI":"350",
                              "GR":"30",
                              "GL":"299",
                              "GD":"1",
                              "GP":"590",
                              "GU":"1",
                              "GT":"502",
                              "GN":"224",
                              "GW":"245",
                              "GY":"595",
                              "HT":"509",
                              "HN":"504",
                              "HU":"36",
                              "IS":"354",
                              "IN":"91",
                              "ID":"62",
                              "IQ":"964",
                              "IE":"353",
                              "IL":"972",
                              "IT":"39",
                              "JM":"1",
                              "JP":"81",
                              "JO":"962",
                              "KZ":"77",
                              "KE":"254",
                              "KI":"686",
                              "KW":"965",
                              "KG":"996",
                              "LV":"371",
                              "LB":"961",
                              "LS":"266",
                              "LR":"231",
                              "LI":"423",
                              "LT":"370",
                              "LU":"352",
                              "MG":"261",
                              "MW":"265",
                              "MY":"60",
                              "MV":"960",
                              "ML":"223",
                              "MT":"356",
                              "MH":"692",
                              "MQ":"596",
                              "MR":"222",
                              "MU":"230",
                              "YT":"262",
                              "MX":"52",
                              "MC":"377",
                              "MN":"976",
                              "ME":"382",
                              "MS":"1",
                              "MA":"212",
                              "MM":"95",
                              "NA":"264",
                              "NR":"674",
                              "NP":"977",
                              "NL":"31",
                              "AN":"599",
                              "NC":"687",
                              "NZ":"64",
                              "NI":"505",
                              "NE":"227",
                              "NG":"234",
                              "NU":"683",
                              "NF":"672",
                              "MP":"1",
                              "NO":"47",
                              "OM":"968",
                              "PK":"92",
                              "PW":"680",
                              "PA":"507",
                              "PG":"675",
                              "PY":"595",
                              "PE":"51",
                              "PH":"63",
                              "PL":"48",
                              "PT":"351",
                              "PR":"1",
                              "QA":"974",
                              "RO":"40",
                              "RW":"250",
                              "WS":"685",
                              "SM":"378",
                              "SA":"966",
                              "SN":"221",
                              "RS":"381",
                              "SC":"248",
                              "SL":"232",
                              "SG":"65",
                              "SK":"421",
                              "SI":"386",
                              "SB":"677",
                              "ZA":"27",
                              "GS":"500",
                              "ES":"34",
                              "LK":"94",
                              "SD":"249",
                              "SR":"597",
                              "SZ":"268",
                              "SE":"46",
                              "CH":"41",
                              "TJ":"992",
                              "TH":"66",
                              "TG":"228",
                              "TK":"690",
                              "TO":"676",
                              "TT":"1",
                              "TN":"216",
                              "TR":"90",
                              "TM":"993",
                              "TC":"1",
                              "TV":"688",
                              "UG":"256",
                              "UA":"380",
                              "AE":"971",
                              "GB":"44",
                              "US":"1",
                              "UY":"598",
                              "UZ":"998",
                              "VU":"678",
                              "WF":"681",
                              "YE":"967",
                              "ZM":"260",
                              "ZW":"263",
                              "BO":"591",
                              "BN":"673",
                              "CC":"61",
                              "CD":"243",
                              "CI":"225",
                              "FK":"500",
                              "GG":"44",
                              "VA":"379",
                              "HK":"852",
                              "IR":"98",
                              "IM":"44",
                              "JE":"44",
                              "KP":"850",
                              "KR":"82",
                              "LA":"856",
                              "LY":"218",
                              "MO":"853",
                              "MK":"389",
                              "FM":"691",
                              "MD":"373",
                              "MZ":"258",
                              "PS":"970",
                              "PN":"872",
                              "RE":"262",
                              "RU":"7",
                              "BL":"590",
                              "SH":"290",
                              "KN":"1",
                              "LC":"1",
                              "MF":"590",
                              "PM":"508",
                              "VC":"1",
                              "ST":"239",
                              "SO":"252",
                              "SJ":"47",
                              "SY":"963",
                              "TW":"886",
                              "TZ":"255",
                              "TL":"670",
                              "VE":"58",
                              "VN":"84",
                              "VG":"284",
                              "VI":"340"]
    if countryDictionary[country] != nil {
        return countryDictionary[country]!
    }
        
    else {
        return ""
    }
    
}




//get cameraview
func callForCamera(viewcontroller : UIViewController) {
  

                let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
                //identifier to the perticular viewcontroller
                let initialViewController = storyboard.instantiateViewController(withIdentifier: STORYBOARD_CAMERAVC)
                viewcontroller.present(initialViewController, animated: true, completion: nil)
    
    

}
//gives a current country code
let locale = Locale.current
let COUNTRY_CODE = "+" + getCountryPhonceCode(locale.regionCode!)



func AlertMessage(title : String, message : String, viewController : UIViewController) {
    //alert
    let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert) //Replace UIAlertControllerStyle.Alert by UIAlertControllerStyle.alert
    
    // Replace UIAlertActionStyle.Default by UIAlertActionStyle.default
    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
        (result : UIAlertAction) -> Void in
        
    }
    
    alertController.addAction(okAction)
    viewController.present(alertController, animated: true, completion: nil)
}



func postImage(image : UIImage?, viewController : UIViewController)  {
     var imageLink = ""
    if let img = image {
        let urlStr = "https://post.imageshack.us/upload_api.php"
        let url = URL(string: urlStr)!
        let imgData = UIImageJPEGRepresentation(img, 0.2)!
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
                        
                    }
                }
            case.failure(_): break
            }
        })
    }
    else{
        
        AlertMessage(title: "Image Post", message: "please check the internet, try again", viewController: viewController)
        
        // self.makeAlert("Missing Fields", msg: "In order to post you must include a Picture and a Caption")
    }
    
}

func getImageUrl(link : String) -> String {
    return link
}

extension UIView {
    func circularControl( cornerRadius : CGFloat)  {
        self.layer.masksToBounds = true;
        self.layer.cornerRadius = cornerRadius;
    }
    
    func signatureView( cornerRadius : CGFloat) {
        let path = UIBezierPath(roundedRect:self.bounds,
                                byRoundingCorners:[.topRight, .bottomLeft],
                                cornerRadii: CGSize(width: cornerRadius, height:  cornerRadius))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
    }
}

