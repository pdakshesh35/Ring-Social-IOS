//
//  ChatCell.swift
//  RingSocial
//
//  Created by Dakshesh patel on 6/23/17.
//  Copyright © 2017 Dakshesh patel. All rights reserved.
//

import UIKit

class ChatCell: UICollectionViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var profileimg: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var lastMessage: UILabel!
    @IBOutlet weak var time: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.circularControl(cornerRadius: 10.0)
        bgView.layer.borderWidth = 1.0
        bgView.layer.borderColor = UIColor.white.cgColor
        
        
        profileimg.signatureView(cornerRadius: 10)
        // Initialization code
    }

}
