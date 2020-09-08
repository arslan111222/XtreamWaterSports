//
//  ConditionModel.swift
//  Xtreme Water Sports
//
//  Created by Noman Umar on 8/1/19.
//  Copyright © 2019 Noman Umar. All rights reserved.
//

import Foundation

struct conditionModel :Codable {

    
    var id :Int?
    var title :[titleResponse]?
    var conditions :[conditionResponse]?
    var booking_type :[String]?
    var countries : [String]?
    var tax:Float?
    
}


struct conditionResponse :Codable {
    

    var condition_english :String?
    var condition_arabic :String?
}


struct titleResponse :Codable {
    
    var title_english :String?
    var title_arabic :String?
   
}

