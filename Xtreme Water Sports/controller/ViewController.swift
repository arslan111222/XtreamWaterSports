//
//  ViewController.swift
//  Xtreme Water Sports
//
//  Created by Noman Umar on 8/1/19.
//  Copyright © 2019 Noman Umar. All rights reserved.
//

import UIKit
import SwifterSwift
import SwiftSignatureView
import PDFKit
import MessageUI
import DropDown



let DocFileName = "example.pdf"
let DocPath = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(DocFileName)

class ViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource,UITextFieldDelegate, SwiftSignatureViewDelegate, MFMailComposeViewControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate{

    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    var condition:conditionModel!
    var TimeIn :String?
    var TimeOut :String?
    var imageDict = [String:UIImage]()
    var titleEng: String?
    var titleArabic: String?
    var conditionEng = ""
    var conditionArabic = ""
    var IdImg :UIImage? = nil
    
    
    let dropDownBookingType = DropDown()
    
    let dropDownPaymentType = DropDown()
    
    let dropDownScheduleBooking = DropDown()
    
    let dropDownNationality = DropDown()
    
    var Countries = [String]()
    var Schedule = ["30 min","1 hr","1.5 hr","2 hr","2.5 hr","3 hr","3.5 hr","4 hr","4.5 hr","5 hr","5.5 hr","6 hr"]
    var booking = [String]()
    
    var isCheck = false
    
    var userEmail = "nomanumar11111@gmail.com"
    
    
    override func viewDidLoad() {
        tableView.register(UINib(nibName: "HeaderImageTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderImageTableViewCell")
        
        //contentTableViewCell
        
        tableView.register(UINib(nibName: "contentTableViewCell", bundle: nil), forCellReuseIdentifier: "contentTableViewCell")
        
        
        tableView.register(UINib(nibName: "signatureViewTableViewCell", bundle: nil), forCellReuseIdentifier: "signatureViewTableViewCell")
        
        
        //signatureViewTableViewCell
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.loadOrderAPi()
        //UserDefaults.standard.removeObject(forKey: "coupon_percentage")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.hideKeyboardWhenTappedAround()
        tableView.reloadData()
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.condition == nil {
            return  0
        }
        return 4
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderImageTableViewCell", for: indexPath) as! HeaderImageTableViewCell
            
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "contentTableViewCell", for: indexPath) as! contentTableViewCell
            if indexPath.row == 1{
        
        
        
           cell.forEnglishLa.text = self.titleEng
           cell.forArabicLa.text = self.titleArabic
           cell.forEnglishLa.textAlignment = .center
           cell.forArabicLa.textAlignment = .center
                
                
    
            }else if indexPath.row == 2{
                
                cell.forEnglishLa.text = self.conditionEng
                cell.forArabicLa.text = self.conditionArabic
                cell.forArabicLa.textAlignment = .right
                    
                    
                
                cell.forEnglishLa.font = UIFont.boldSystemFont(ofSize: 22.0)
                cell.forArabicLa.font = UIFont.boldSystemFont(ofSize: 22.0)
                
            }else if indexPath.row == 3{
                
                let signatureCell = tableView.dequeueReusableCell(withIdentifier: "signatureViewTableViewCell", for: indexPath) as! signatureViewTableViewCell
                
                
                signatureCell.phoneNumber.tag = 4
                signatureCell.phoneNumber.delegate = self
                
                
                signatureCell.timeInTF.tag = 8
                signatureCell.timeInTF.delegate = self
                
                signatureCell.timeOutTF.tag = 9
                signatureCell.timeOutTF.delegate = self
                
                signatureCell.totalTF.tag = 10
                signatureCell.totalTF.delegate = self
                
                signatureCell.nationalityTF.tag = 1
                signatureCell.nationalityTF.delegate = self
                
                signatureCell.schedualTF.tag = 2
                signatureCell.schedualTF.delegate = self
                
                signatureCell.bookingTF.tag = 3
                signatureCell.bookingTF.delegate = self
                
                signatureCell.tfPaymentMethod.tag = 11
                signatureCell.tfPaymentMethod.delegate = self
                
                signatureCell.tfAmountWithText.tag = 12
                signatureCell.tfAmountWithText.delegate = self
                
                signatureCell.costomerSignatureView.delegate = self
                signatureCell.captainSignatureView.delegate = self
                
                signatureCell.jetskiTF.delegate = self
                signatureCell.jetskiTF.tag = 13
                
                let tapMainView = UITapGestureRecognizer(target: self, action: #selector(mainView(sender:)))
                signatureCell.checkBoxImage.addGestureRecognizer(tapMainView)
                signatureCell.checkBoxImage.isUserInteractionEnabled = true
                
                
                
                signatureCell.buSubmit.addTarget(self, action: #selector(buSubmitClick), for: .touchUpInside)
                
                //buResetClick
                
                signatureCell.resetButton.addTarget(self, action: #selector(buResetClick), for: .touchUpInside)
                
                
                signatureCell.buCamera.addTarget(self, action: #selector(buCemeraClick), for: .touchUpInside)
                
                
                
                return signatureCell
                
            }
            return cell
        }
    }
    
    
    
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField.tag == 1{
            
            self.createDropDownsNationality(arry: self.Countries)
            self.dropDownNationality.show()
            return  true
        }
        
        if textField.tag == 2{
            
            self.createDropDownsSchedule()
            self.dropDownScheduleBooking.show()
            return  false
        }
        
        if textField.tag == 3{
            
            self.createDropDownsBooking()
            self.dropDownBookingType.show()
            return  false
        }
        
        if textField.tag == 11{
            
            self.createDropDownsPaymentMethod()
            self.dropDownPaymentType.show()
            return  false
        }
        
        if textField.tag == 12{
            
            return  false
        }
        
        
        
        if textField.tag == 8 || textField.tag == 9{
            
            //timeViewController
            
            RPicker.selectDate(title: "Select Time", datePickerMode: .time, didSelectDate: { (selectedDate) in
                // TODO: Your implementation for date
                textField.text   = selectedDate.dateString("hh:mm a")
            })
            
            
            return  false
        }
        
        
        return  true
    }
    
    func applyTax(tax: String) {
        let indexPath = IndexPath(row: 3, section: 0)
        let cell = self.tableView.cellForRow(at: indexPath) as! signatureViewTableViewCell
        
        if tax != "" {
        let amount = Float(tax)
        let tax = self.condition.tax
        
        let calculate = (amount! * (tax!/100))
        let total = calculate + amount!
        
            cell.tfAmountWithText.text = String(Int(total.rounded(.up)))
        }else {
            cell.tfAmountWithText.text = String(0)
        }
        
    }
    
    func filterContentForSearchText(searchText: String) {
        let filterdTerms = self.Countries.filter { term in
            return term.lowercased().contains(searchText.lowercased())

        }
        
        self.createDropDownsNationality(arry: filterdTerms)
        self.dropDownNationality.show()
    }
    
    
    
    func createDropDownsNationality(arry:[String]) {
        
        
        let indexPath = IndexPath(row: 3, section: 0)
        let cell = self.tableView.cellForRow(at: indexPath) as! signatureViewTableViewCell
        //----------------------------------------------------------------------
        
        self.dropDownNationality.anchorView = cell.nationalityTF// UIView or UIBarButtonItem
        self.dropDownNationality.direction = .any
        self.dropDownNationality.bottomOffset = CGPoint(x: 0, y:(self.dropDownNationality.anchorView?.plainView.bounds.height)!)
        
        
        
        
        //dropDown.backgroundColor = UIColor.lightGray
        //dropDown.textColor = UIColor.white
        
        // The list of items to display. Can be changed dynamically
        self.dropDownNationality.dataSource = arry
        self.dropDownNationality.direction = .bottom
        // Action triggered on selection
        self.dropDownNationality.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            cell.nationalityTF.text = item
            
        }
        
        // Will set a custom width instead of the anchor view width
        self.dropDownNationality.width = cell.nationalityTF.width
        DropDown.appearance().textFont = UIFont.systemFont(ofSize: 23)
        self.dropDownNationality.show()
        // dropDownColor.hide()
        
        //----------------------------------------------------------------------
        
    }
    
    func createDropDownsSchedule() {
        
        
        let indexPath = IndexPath(row: 3, section: 0)
        let cell = self.tableView.cellForRow(at: indexPath) as! signatureViewTableViewCell
        //----------------------------------------------------------------------
        
        self.dropDownScheduleBooking.anchorView = cell.schedualTF// UIView or UIBarButtonItem
        self.dropDownScheduleBooking.direction = .any
        self.dropDownScheduleBooking.bottomOffset = CGPoint(x: 0, y:(self.dropDownScheduleBooking.anchorView?.plainView.bounds.height)!)
        
        
        
        
        //dropDown.backgroundColor = UIColor.lightGray
        //dropDown.textColor = UIColor.white
        
        // The list of items to display. Can be changed dynamically
        self.dropDownScheduleBooking.dataSource = self.Schedule
        // Action triggered on selection
        self.dropDownScheduleBooking.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            cell.schedualTF.text = item
            
        }
        
        // Will set a custom width instead of the anchor view width
        self.dropDownScheduleBooking.width = cell.schedualTF.width
         DropDown.appearance().textFont = UIFont.systemFont(ofSize: 23)
        self.dropDownScheduleBooking.show()
        // dropDownColor.hide()
        
        //----------------------------------------------------------------------
        
    }
    
    
    func createDropDownsPaymentMethod() {
        
        
        let indexPath = IndexPath(row: 3, section: 0)
        let cell = self.tableView.cellForRow(at: indexPath) as! signatureViewTableViewCell
        //----------------------------------------------------------------------
        
        self.dropDownPaymentType.anchorView = cell.tfPaymentMethod// UIView or UIBarButtonItem
        self.dropDownPaymentType.direction = .any
        self.dropDownPaymentType.bottomOffset = CGPoint(x: 0, y:(self.dropDownPaymentType.anchorView?.plainView.bounds.height)!)
        
        
        
        
        //dropDown.backgroundColor = UIColor.lightGray
        //dropDown.textColor = UIColor.white
        
        // The list of items to display. Can be changed dynamically
        self.dropDownPaymentType.dataSource = ["Card","Cash"]
       
        // Action triggered on selection
        self.dropDownPaymentType.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            cell.tfPaymentMethod.text = item
            
        }
        
        // Will set a custom width instead of the anchor view width
        self.dropDownPaymentType.width = cell.tfPaymentMethod.width
        DropDown.appearance().textFont = UIFont.systemFont(ofSize: 23)
        self.dropDownPaymentType.show()
        // dropDownColor.hide()
        
        //----------------------------------------------------------------------
        
    }
    
    
    func createDropDownsBooking() {
        
        
        let indexPath = IndexPath(row: 3, section: 0)
        let cell = self.tableView.cellForRow(at: indexPath) as! signatureViewTableViewCell
        //----------------------------------------------------------------------
        
        self.dropDownBookingType.anchorView = cell.bookingTF// UIView or UIBarButtonItem
        self.dropDownBookingType.direction = .any
        self.dropDownBookingType.bottomOffset = CGPoint(x: 0, y:(self.dropDownBookingType.anchorView?.plainView.bounds.height)!)
        
        
        
        
        //dropDown.backgroundColor = UIColor.lightGray
        //dropDown.textColor = UIColor.white
        
        // The list of items to display. Can be changed dynamically
        self.dropDownBookingType.dataSource = self.booking
       
        // Action triggered on selection
        self.dropDownBookingType.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            cell.bookingTF.text = item
            
        }
        
        // Will set a custom width instead of the anchor view width
        self.dropDownBookingType.width = cell.bookingTF.width
        DropDown.appearance().textFont = UIFont.systemFont(ofSize: 23)
        self.dropDownBookingType.show()
        // dropDownColor.hide()
        
        //----------------------------------------------------------------------
        
    }
    
    
    
    @objc func mainView(sender: UITapGestureRecognizer) {
        
        let cellTag = sender.view
        
        let index  = (cellTag?.tag)!
        print(index as Any)
        
        let indexPath = IndexPath(row: 3, section: 0)
        let cell = self.tableView.cellForRow(at: indexPath) as! signatureViewTableViewCell
        
        if self.isCheck {
            self.isCheck = false
            cell.checkBoxImage.image = UIImage(named: "empty_checkbox")
        }else{
            self.isCheck = true
            cell.checkBoxImage.image = UIImage(named: "filed_checkbox")
        }
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
        
        
        let index = textField.tag
        let updatedString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string)
        
        if index == 1{
            self.filterContentForSearchText(searchText: updatedString!)
        }
        
        
        
        if textField.tag == 4 {
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        
        
        if textField.tag == 13 {
                   let allowedCharacters = CharacterSet(charactersIn:"0123456789")//Here change this characters based on your requirement
                   let characterSet = CharacterSet(charactersIn: string)
                   return allowedCharacters.isSuperset(of: characterSet)
               }
        
        
        
        if textField.tag == 10 {
            let allowedCharacters = CharacterSet(charactersIn:"0123456789")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            let result = allowedCharacters.isSuperset(of: characterSet)
            
            if result{
               
                self.applyTax(tax: updatedString!)
    
            }else{
               return false
            }
        }
        
        
        
        return true
    }
    
    
    
    
    
    func sendEmail() {
        
        
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
    
        if(  MFMailComposeViewController.canSendMail() ) {
            print("Can send email.")
            
            let mailComposer = MFMailComposeViewController()
            mailComposer.mailComposeDelegate = self
            
            //Set the subject and message of the email
            
                //userEmail
            mailComposer.setToRecipients([self.userEmail])
           
            
            mailComposer.setSubject("Have you heard a swift?")
            mailComposer.setMessageBody("This is what they sound like.", isHTML: false)
            
            if let fileData = NSData(contentsOf: DocPath!) {
                print("File data loaded.")
                
                mailComposer.addAttachmentData(fileData as Data, mimeType: "pdf/csv", fileName: "example.pdf")
                
            }
            
            
            self.present(mailComposer, animated: true, completion: nil)
        }else{
            
            print("cannot send email")
        }
    }
    
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    @objc func buSubmitClick(sender: UIButton){
        
        
        

//        generatePDF(view: self.tableView) { (Bo) in
//
//
//            if Bo!{
//                ApiManager.postPDF { (data, isUpload) in
//                    print(data)
//                    print(isUpload)
//                }
//
//            }
//
//        }

        
        
        
        

          let indexPath = IndexPath(row: 3, section: 0)
          let cell = self.tableView.cellForRow(at: indexPath) as! signatureViewTableViewCell

        DispatchQueue.main.async {

            let name = cell.nameTF.text
            let email = cell.emailTF.text
            let IdNumber = cell.idNumberTF.text
            let phone = cell.phoneNumber.text
            let boolingSchedual = cell.schedualTF.text
            let captain = cell.captainTF.text
            let jetski = cell.jetskiTF.text
            let timein = cell.timeInTF.text
            let timeOut = cell.timeOutTF.text
            let total = cell.totalTF.text
            let costomerSignatur = cell.costomerSignatureView.getCroppedSignature()
            let captainSignatur = cell.captainSignatureView.getCroppedSignature()
            let country = cell.nationalityTF.text
            let schedule = cell.schedualTF.text
            let bookType = cell.bookingTF.text
            let paymentMethod = cell.tfPaymentMethod.text
            let amountWithText = cell.tfAmountWithText.text
            print(country)
            
            

            //croppedSignatureView.image = signatureView.getCroppedSignature()


            print(name!)
            print(email!)
            print(IdNumber!)
            print(phone!)
            print(boolingSchedual!)
            print(captain!)
            print(jetski!)
            print(timein!)
            print(timeOut!)
            print(total!)





            if name!.isEmpty{
                self.showAlert(title: "Message", message: "Enter Costomer Name")
                return
            }


            if email!.isEmpty{
                self.showAlert(title: "Message", message: "Enter Costomer Email")
                return
            }


            if email!.isValidEmail == false{
                self.showAlert(title: "Message", message: "Enter Valid Email")
                return
            }
            
            if country!.isEmpty{
                self.showAlert(title: "Message", message: "Enter Your Nationality")
                return
            }

            if IdNumber!.isEmpty{
                self.showAlert(title: "Message", message: "Enter Costomer ID Number")
                return
            }
            
            if self.IdImg == nil{
                self.showAlert(title: "Message", message: "Enter ID Image")
                return
            }

            if phone!.isEmpty{
                
                self.showAlert(title: "Message", message: "Enter Phone Number")
                return

            }

            
            if schedule!.isEmpty{
                
                self.showAlert(title: "Message", message: "Enter Schedule Booking")
                return
                
            }
            
            if bookType!.isEmpty{
                
                self.showAlert(title: "Message", message: "Enter Booking Type")
                return
                
            }
            
            if costomerSignatur != nil {

                print(costomerSignatur!)

            }else{
                self.showAlert(title: "Message", message: "Enter Costomer Signature")
                return
            }

            if captain!.isEmpty{
                self.showAlert(title: "Message", message: "Enter Captain")
                return
            }

            if jetski!.isEmpty{
                self.showAlert(title: "Message", message: "Enter Jetski")
                return
            }




            if  captainSignatur != nil {

                print(captainSignatur!)

            }else{
                self.showAlert(title: "Message", message: "Enter Captain Signature")
                return
            }


            if timein!.isEmpty {
                self.showAlert(title: "Message", message: "Enter Time in")
                return
            }

            if timeOut!.isEmpty{
                self.showAlert(title: "Message", message: "Enter Time out")
                return
            }

            if total!.isEmpty{
                self.showAlert(title: "Message", message: "Enter Total")
                return
            }

            if !(self.isCheck){
                self.showAlert(title: "Message", message: "Accept Term & Condition")
                return
            }
            
            if paymentMethod!.isEmpty{
                self.showAlert(title: "Message", message: "Enter Payment Method")
                return
            }

            

            let url = URLs.storeUrl



            self.imageDict["user_signature"]  = costomerSignatur
            self.imageDict["captain_signature"]  = captainSignatur
            self.imageDict["id_image"] = self.IdImg

            let param = ["name" : name!, "email" : email! , "id_number":IdNumber! , "contact" : phone!, "booking": schedule!,"nationality":country!,
                         "booking_type":bookType! , "captain" : captain! , "jetski" : jetski! , "time_in" : timein! , "time_out": timeOut! , "total_amount" : amountWithText!,"payment_method":paymentMethod,"amount_without_tax":total,]


            self.appdelegate.showActivityIndicatory(uiView: self.view)

            ApisCallingClass.submitData(url: url, parameters: param as [String : Any], images: self.imageDict, onCompletion: { (data) in
                self.appdelegate.hideActivityIndicatory()
                if data != nil
                {
                    if data?.status == 1{


                        print("Button Click")
                        cell.costomerSignatureView.clear()
                        cell.captainSignatureView.clear()
                        cell.nameTF.text        =  ""
                        cell.emailTF.text       =  ""
                        cell.idNumberTF.text    =  ""
                        cell.phoneNumber.text   =  ""
                        cell.captainTF.text     =  ""
                        cell.jetskiTF.text      =  ""
                        cell.timeInTF.text      =  ""
                        cell.timeOutTF.text     =  ""
                        cell.totalTF.text       =  ""
                        cell.schedualTF.text    =  ""
                        cell.nationalityTF.text = ""
                        cell.bookingTF.text     = ""
                        cell.tfPaymentMethod.text = ""
                        cell.tfAmountWithText.text = ""
                        self.IdImg = nil
                        self.isCheck = false
                        cell.checkBoxImage.image = UIImage(named: "empty_checkbox")
                        cell.idImage.image = UIImage(named: "placeholder")

                    self.showAlert(title: "Message", message: "Successfully add data")


                    }else{
                        self.showAlert(title: "Message", message: data?.message)
                    }

                }else{
                    
                    self.showAlert(title: "Fail", message: "Fail while upload data")
                }
            })


        }
    }
    //buCemeraClick
    
    //if cemera button click
    @objc func buCemeraClick(sender: UIButton)
    {
        print("Cemera")
        
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        addActionSheetForiPad(actionSheet: alert)
        
        self.present(alert, animated: true, completion: nil)
        
        
      
        
        
        
    }
    
    //for camera
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //for gallery
    func openGallery()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            self.IdImg = pickedImage
            let indexPath = IndexPath(row: 3, section: 0)
            let cell = self.tableView.cellForRow(at: indexPath) as! signatureViewTableViewCell
            
            cell.idImage.image = self.IdImg
            cell.idImage.contentMode = .scaleAspectFill
            
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func buResetClick(sender: UIButton){
        
        let indexPath = IndexPath(row: 3, section: 0)
        let cell = self.tableView.cellForRow(at: indexPath) as! signatureViewTableViewCell
        
        print("Button Click")
        cell.costomerSignatureView.clear()
        cell.captainSignatureView.clear()
        cell.nameTF.text        =  ""
        cell.emailTF.text       =  ""
        cell.idNumberTF.text    =  ""
        cell.phoneNumber.text   =  ""
        cell.captainTF.text     =  ""
        cell.jetskiTF.text      =  ""
        cell.timeInTF.text      =  ""
        cell.timeOutTF.text     =  ""
        cell.totalTF.text       =  ""
        cell.schedualTF.text    =  ""
        cell.nationalityTF.text = ""
        cell.bookingTF.text     = ""
        cell.tfPaymentMethod.text = ""
        cell.tfPaymentMethod.text = ""
        self.IdImg = nil
        cell.checkBoxImage.image = UIImage(named: "empty_checkbox")
        
        
    }
    
    
    //-------------------
    //signature view default function
    public func swiftSignatureViewDidTapInside(_ view: SwiftSignatureView) {
        // noop
    }
    
    public func swiftSignatureViewDidPanInside(_ view: SwiftSignatureView, _ pan:UIPanGestureRecognizer) {
        // noop
    }
    
    //--------------------
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 400
        }
         return UITableView.automaticDimension
    }
    
    
    func loadOrderAPi(){
        
        DispatchQueue.main.async {
        
        
        let url = URLs.conditionsUrl
        self.appdelegate.showActivityIndicatory(uiView: self.view)
        ApisCallingClass.getConditions(url: url) { (data) in
            self.appdelegate.hideActivityIndicatory()
            if data != nil {
                self.condition = data
                self.Countries = (data?.countries)!
                self.booking = (data?.booking_type)!
                
                self.titleEng = data?.title![0].title_english
                self.titleArabic = data?.title![0].title_arabic
                
                let count =  self.condition.conditions?.count
            
                
                for i in 0..<count! {
                    let con = self.condition.conditions![i]
                    
                    self.conditionEng = self.conditionEng + " \n" + String(i + 1) + ".  " + con.condition_english!
                    self.conditionArabic = self.conditionArabic + " \n" + String(i + 1) + ".  " + con.condition_arabic!
                    
                }
                
                
                
                
                self.tableView.reloadData()
            }else{
                self.appdelegate.hideActivityIndicatory()
                self.showAlert(title: "Message", message: "Condition fetch error")
            }
        }
        
    }
    }
    
    
    
    
    
    //============================================================
    
    
    
    


}







extension UIViewController {
    public func addActionSheetForiPad(actionSheet: UIAlertController) {
        if let popoverPresentationController = actionSheet.popoverPresentationController {
            popoverPresentationController.sourceView = self.view
            popoverPresentationController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverPresentationController.permittedArrowDirections = []
        }
    }
}
