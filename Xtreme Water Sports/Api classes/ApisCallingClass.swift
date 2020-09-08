//
//  ApisCallingClass.swift
//  SideMenu
//
//  Created by Noman Umar on 7/12/19.
//  Copyright © 2019 com.Tektiks.postQuam. All rights reserved.
//

import Foundation
import SwiftyJSON


class ApisCallingClass: NSObject {
/*

class func GetProductDetail(user:productID, url:String , onCompletion :@escaping (GetProductModel?)-> Void){
    
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    let jsonData = try! encoder.encode(user)
    print(jsonData)
    ApiManager.post(Url: url, user: jsonData) { (data ,success:Bool) in
        
        if success {
        
            do {
                
                print(JSON(data))
                let jsonDecoder = JSONDecoder()
                let res = try jsonDecoder.decode(GetProductModel.self, from: data ) as GetProductModel
                
                onCompletion(res)
                
                
            } catch let error {
                print(" Error ---> \(error)")
                
            }

        } else {
            
                print(JSON(data))
                onCompletion(nil)

        }
    }
    }
    
   */
    //discounts
    
    
    
    class func getConditions(url:String , onCompletion :@escaping (conditionModel?)-> Void){
     
        ApiManager.get(Url: url) { (data ,success:Bool) in
            
            if success {
                do {
                    
                    print(JSON(data))
                    let jsonDecoder = JSONDecoder()
                    let res = try jsonDecoder.decode(conditionModel.self, from: data ) as conditionModel
                
                        
                        
                        onCompletion(res)
                    
                    
                } catch let error {
                    onCompletion(nil)
                    print(" Error ---> \(error)")
                    
                }
                
            } else {

                    onCompletion(nil)
                    
                
                
                    
                
                
            }
        }
    }
    
    
    
    class func submitData(url:String,parameters: [String:Any] ,images: [String:UIImage], onCompletion :@escaping (storeResponse?)-> Void){
        
        
        ApiManager.postImageWithText_images(Url: url, parameters: parameters , images: images, onCompletion :{ (data ,success:Bool) in
            
            
            if success {
                
                do {
                    
                    print(JSON(data))
                    let jsonDecoder = JSONDecoder()
                    let res = try jsonDecoder.decode(storeResponse.self, from: data ) as storeResponse
                    
                    
                    onCompletion(res)
                    
                    
                } catch let error {
                    print(" Error ---> \(error)")
                    onCompletion(nil)
                    
                }
                
            } else {
                
                print(JSON(data))
                onCompletion(nil)
                
            }
            
        })
        
        
    }
    
}
