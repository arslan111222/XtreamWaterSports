//
//  PDF genration.swift
//  Xtreme Water Sports
//
//  Created by Noman Umar on 8/5/19.
//  Copyright © 2019 Noman Umar. All rights reserved.
//

import Foundation
import SimplePDF
import MessageUI
import SwifterSwift
import UIKit





func generatePDF(view : UITableView ,onCompletion :@escaping (Bool?)-> Void){
    
    
    
    let priorBounds: CGRect = view.bounds
    let fittedSize: CGSize =  view.sizeThatFits(CGSize(width: priorBounds.size.width, height: view.contentSize.height))
    view.bounds = CGRect(x: 0, y: 0, width: fittedSize.width, height: fittedSize.height)
    let pdfPageBounds: CGRect = CGRect(x: 0, y: 0, width: fittedSize.width, height: (fittedSize.height))
    let pdfData: NSMutableData = NSMutableData()
    UIGraphicsBeginPDFContextToData(pdfData, pdfPageBounds, nil)
    UIGraphicsBeginPDFPageWithInfo(pdfPageBounds, nil)
    view.layer.render(in: UIGraphicsGetCurrentContext()!)
    UIGraphicsEndPDFContext()
    
    
    if let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
        
        let documentsFileName = documentDirectories + "/" + DocFileName
        
        
        //let pdfData = pdf.generatePDFdata()
        do{
            //(documentsFileName, options: .DataWritingAtomic)
            try pdfData.write(to: DocPath!, options: .atomic)
            print("\nThe generated pdf can be found at:")
            print("\n\t\(documentsFileName)\n")
            //sendEmail(path: path!)
            
           
            
            
            onCompletion(true)
            
            
        }catch{
            print(error)
        }
    }
    
    
    
}
