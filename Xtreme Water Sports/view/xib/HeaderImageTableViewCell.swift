//
//  HeaderImageTableViewCell.swift
//  Xtreme Water Sports
//
//  Created by Noman Umar on 8/1/19.
//  Copyright © 2019 Noman Umar. All rights reserved.
//

import UIKit

class HeaderImageTableViewCell: UITableViewCell {
    @IBOutlet weak var bottomView: UIView!
    
    override func awakeFromNib() {
        
       // self.bottomView.roundCorners(corners: [.topLeft,.topRight], radius: 30)
       
        self.bottomView.clipsToBounds = true
        self.bottomView.layer.cornerRadius = 38
        self.bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

