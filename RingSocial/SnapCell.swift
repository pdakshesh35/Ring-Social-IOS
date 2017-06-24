//
//  SnapCell.swift
//  RingSocial
//
//  Created by Dakshesh patel on 6/22/17.
//  Copyright © 2017 Dakshesh patel. All rights reserved.
//

import UIKit

class SnapCell: UICollectionViewCell {
    @IBOutlet weak var status: UIImageView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var time: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        img.circularControl(cornerRadius: img.frame.width/2)
        // Initialization code
    }

}
