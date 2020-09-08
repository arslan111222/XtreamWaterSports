//
//  signatureViewTableViewCell.swift
//  Xtreme Water Sports
//
//  Created by Noman Umar on 8/1/19.
//  Copyright © 2019 Noman Umar. All rights reserved.
//

import UIKit
import TextFieldEffects
import SwifterSwift
import SwiftSignatureView



class signatureViewTableViewCell: UITableViewCell {

    @IBOutlet weak var resetButton: UIButton!
    
    @IBOutlet weak var nameTF: HoshiTextField!
    @IBOutlet weak var emailTF: HoshiTextField!
    
    @IBOutlet weak var nationalityTF: HoshiTextField!
    @IBOutlet weak var idNumberTF: HoshiTextField!
    @IBOutlet weak var phoneNumber: HoshiTextField!
    @IBOutlet weak var schedualTF: HoshiTextField!
    @IBOutlet weak var costomerSignatureView: SwiftSignatureView!
    @IBOutlet weak var captainTF: HoshiTextField!
    @IBOutlet weak var jetskiTF: HoshiTextField!
    @IBOutlet weak var captainSignatureView: SwiftSignatureView!
    @IBOutlet weak var timeInTF: HoshiTextField!
    @IBOutlet weak var timeOutTF: HoshiTextField!
    @IBOutlet weak var totalTF: HoshiTextField!
    @IBOutlet weak var buSubmit: UIButton!
    @IBOutlet weak var bookingTF: HoshiTextField!
    
    @IBOutlet weak var tfPaymentMethod: HoshiTextField!
    @IBOutlet weak var tfAmountWithText: HoshiTextField!
    @IBOutlet weak var idImage: UIImageView!
    @IBOutlet weak var checkBoxImage: UIImageView!
    
    @IBOutlet weak var buCamera: UIButton!
    override func awakeFromNib() {
        
        
//                   let myFrame =  CGRect(x: 0, y: 0, width: 35, height: 35)
//                    self.nationalityTF.AddImage(direction: .Right, imageName: "dropdown", Frame: myFrame, backgroundColor: .white)
        
        
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
