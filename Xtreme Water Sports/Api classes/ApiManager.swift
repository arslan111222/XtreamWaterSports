//
//  ApiManager.swift
//  SideMenu
//
//  Created by Noman Umar on 7/12/19.
//  Copyright © 2019 com.Tektiks.postQuam. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class ApiManager: NSObject {
    
    class func get(Url:String , onCompletion :@escaping (Data, _ success:Bool)-> Void){
        
        
        let urlNew:String = Url.replacingOccurrences(of: " ", with: "%20")
        print(urlNew)
        let url = URL(string:urlNew)!
        //Bearerkoes
        print("->\(url)")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        
        
        
        Alamofire.request(request)
            .validate(statusCode: 200..<600)
            .responseJSON { response in
                
                
                _ = response.result.value
                
                switch response.result {
                    
                case .failure:
                    let data : Data = response.data!
                    print(JSON(data))
                    onCompletion(data , false)
                    
                case .success:
                    
                    let data:Data = response.data!
                    onCompletion(data , true)
                }
        }
        
    }
    
    
    
    
    class func post(Url:String, user:Data , onCompletion :@escaping (Data, _ success:Bool)-> Void)
    {
        
        
        
        print("PRINT IN POST--->\(JSON(user))")
        
        
        let urlNew:String = Url.replacingOccurrences(of: " ", with: "%20")
        
        let url = URL(string:urlNew)!
        //Bearer
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
       
       
        
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        request.httpBody = user
        
        
        
        Alamofire.request(request)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                
                print("e>1 \(response)"  )
                
                switch response.result {
                    
                case .failure(let error):
                    
                    let data : Data = response.data!
                    print("print DaTA-->\(JSON(data))")
                    print("ERROR--->\(error)")
                    onCompletion(data , false)
                    
                case .success:
                    
                    let data:Data = response.data!
                    onCompletion(data , true)
                }
        }
    }
    
    class func postNoBody(Url:String , onCompletion :@escaping (Data, _ success:Bool)-> Void)
    {
        
    
        
        let urlNew:String = Url.replacingOccurrences(of: " ", with: "%20")
        
        let url = URL(string:urlNew)!
        //Bearer
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
       
     
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
        
        
        
        
        
        Alamofire.request(request)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                
                print("e>1 \(response)"  )
                
                switch response.result {
                    
                case .failure(let error):
                    
                    let data : Data = response.data!
                    print("print DaTA-->\(JSON(data))")
                    print("ERROR--->\(error)")
                    onCompletion(data , false)
                    
                case .success:
                    
                    let data:Data = response.data!
                    onCompletion(data , true)
                }
        }
    }
    
    
    
    
    class func   delete(Url:String , onCompletion :@escaping (Data, _ success:Bool)-> Void){
        
        
        
        
        
        let urlNew:String = Url.replacingOccurrences(of: " ", with: "%20")
        
        let url = URL(string:urlNew)!
        //Bearer
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        
        
        
        
//        let token = ApiToken.getApiToken()
//
//
//        if(token != ""){
//            request.addValue( token! , forHTTPHeaderField: "x-sh-auth")
//        }
//
//
//
//        print(token!)
//
//        let authToken = UserInfoDefault.getAuthorization()
//        let tokenAuth =  "Bearer" + " " + authToken
//
//        print(authToken)
        
//        request.addValue(tokenAuth, forHTTPHeaderField: "Authorization")
        
        
        
        
        
        Alamofire.request(request)
            .validate(statusCode: 200..<600)
            .responseJSON { response in
                
                
                _ = response.result.value
                
                switch response.result {
                    
                case .failure:
                    let data : Data = response.data!
                    print(JSON(data))
                    onCompletion(data , false)
                    
                case .success:
                    
                    let data:Data = response.data!
                    onCompletion(data , true)
                }
        }
        
    }
    
    
    
    class func postImageWithText_images(Url:String, parameters :[String:Any], images :  [String:UIImage]   , onCompletion :@escaping (Data, _ success:Bool)-> Void)
    {
        
        
        // let headers = ["x-sh-auth":token]
        print(Url)
        print(parameters)
        print(images)
        
        
        Alamofire.upload(multipartFormData:{ multipartFormData in
            
            
            
            for (key, value) in parameters {
                let v = value as! String
                multipartFormData.append(v.data(using: .utf8)!, withName: key)
            }
        
            for (key,photo) in images {
                print("\(key)")
                let imageData = photo.jpegData(compressionQuality: 0.25)
                
                multipartFormData.append(imageData!, withName: key, fileName: "sample.png", mimeType: "image/png")
                
            }
            
           
        },
                         usingThreshold:UInt64.init(),
                         to: Url,
                         method:.post,
                         headers: ["content-type" : "multipart/form-data"],
                       //  "content-type" : "curl","Content-Type" : "multipart/form-data"
                         encodingCompletion: { encodingResult in
                            
                            
                            switch encodingResult {
                                
                            case .success(let upload, _, _):
                                upload.responseJSON { response in
                                    let data : Data = response.data!
                                    print("-->success")
                                
                                   print(data)

                                        //Failure completion block
        
                                onCompletion(data, true)
                                    
                                    
                                }
                            case .failure(let encodingError):
                                let data : Data = encodingError.localizedDescription.data(using: encodingError as! String.Encoding)!
                                print("--> fail")
                                print(encodingError)
                                onCompletion(data,false)
                                
                                
                    }
                            
        })
        
    }
    
    
    
    class func postPDF( onCompletion :@escaping (Data, _ success:Bool)-> Void)
    {
        
        
        // let headers = ["x-sh-auth":token]
        
    
        let url = "https://airizo.com/demo/jetski/api/pdfupload"
        
        Alamofire.upload(multipartFormData:{ multipartFormData in
            
            var pdfData :Data!
            if let fileData = NSData(contentsOf: DocPath!) {
                print("File data loaded.")
                
               pdfData = fileData as Data
                
            }
            
                
                multipartFormData.append(pdfData, withName: "pdf_file", fileName: "Genrated_PDf", mimeType:"application/pdf")
            
    
                
                
            
            
                
            
            
            
        },
                         usingThreshold:UInt64.init(),
                         to: url,
                         method:.post,
                         headers: ["content-type" : "multipart/form-data"],
                         //  "content-type" : "curl","Content-Type" : "multipart/form-data"
            encodingCompletion: { encodingResult in
                
                
                switch encodingResult {
                    
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        let data : Data = response.data!
                        print("-->success")
                        
                        print(JSON(data))
                        
                        //Failure completion block
                        
                        onCompletion(data, true)
                        
                        
                    }
                case .failure(let encodingError):
                    let data : Data = encodingError.localizedDescription.data(using: encodingError as! String.Encoding)!
                    print("--> fail")
                    print(encodingError)
                    onCompletion(data,false)
                    
                    
                }
                
        })
        
    }
    
}
