//
//  ChatStoryViewCell.swift
//  RingSocial
//
//  Created by Dakshesh patel on 6/23/17.
//  Copyright © 2017 Dakshesh patel. All rights reserved.
//

import UIKit

class ChatStoryViewCell: UICollectionViewCell {

    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        img.circularControl(cornerRadius: img.frame.width/2)
        // Initialization code
    }

}
