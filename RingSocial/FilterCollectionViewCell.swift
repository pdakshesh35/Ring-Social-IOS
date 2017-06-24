//
//  FilterCollectionViewCell.swift
//  RingSocial
//
//  Created by Dakshesh patel on 6/18/17.
//  Copyright © 2017 Dakshesh patel. All rights reserved.
//

import UIKit
import Foundation

class FilterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        var color = UIColor.white
        imageView.layer.borderColor = color.cgColor
        imageView.layer.borderWidth = 2.0
        imageView.circularControl(cornerRadius: 10)
        
    }
}
