//
//  UsersCell.swift
//  RingSocial
//
//  Created by Dakshesh patel on 6/24/17.
//  Copyright © 2017 Dakshesh patel. All rights reserved.
//

import UIKit

class UsersCell: UICollectionViewCell {

    
    @IBOutlet weak var userimg: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userimg.circularControl(cornerRadius: 10)
        // Initialization code
    }

}
