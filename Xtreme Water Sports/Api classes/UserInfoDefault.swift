//
//  UserInfoDefault.swift
//  SideMenu
//
//  Created by Noman Umar on 7/12/19.
//  Copyright © 2019 com.Tektiks.postQuam. All rights reserved.
//

import Foundation
@objc class UserInfoDefault: NSObject {
    
    //---- save data in user Default----
    
    static func saveCartCount(count: Int) {
        UserDefaults.standard.set(count, forKey: "cartCount")
        UserDefaults.standard.synchronize()
    }
    
    //full name
    static func saveFullName(fname: String) {
        UserDefaults.standard.set(fname, forKey: "full_name")
        UserDefaults.standard.synchronize()
    }
    
    static func saveUserId(id: String) {
        UserDefaults.standard.set(id, forKey: "User_id")
        UserDefaults.standard.synchronize()
    }

    
    
    static func saveEmail(email: String) {
        UserDefaults.standard.set(email, forKey: "email")
        UserDefaults.standard.synchronize()
    }
    
    
    static func savePhone(phone: String) {
        UserDefaults.standard.set(phone, forKey: "phone")
        UserDefaults.standard.synchronize()
    }
    
    static func saveIsUserLogin(isUserLogin: Bool) {
        UserDefaults.standard.set(isUserLogin, forKey: "isUserLogin")
        UserDefaults.standard.synchronize()
    }
    
    
    static func saveIsActive(active: String) {
        UserDefaults.standard.set(active, forKey: "active")
        UserDefaults.standard.synchronize()
    }
    
    
    static func saveUserType(user: String) {
        UserDefaults.standard.set(user, forKey: "user_type")
        UserDefaults.standard.synchronize()
    }
    
    
    
    static func saveDiscountAllowed(discount: String) {
        UserDefaults.standard.set(discount, forKey: "discount_allowed")
        UserDefaults.standard.synchronize()
    }
    
    
    static func saveDiscountValue(value: String) {
        UserDefaults.standard.set(value, forKey: "discount_value")
        UserDefaults.standard.synchronize()
    }
    
    static func saveCouponCode(code: String) {
        UserDefaults.standard.set(code, forKey: "coupon_code")
        UserDefaults.standard.synchronize()
    }
    
    
    
    
    //------- get data in user Default ------

    
    //cartCount
    static func getCartCount() -> Int {
        guard let userValue =  UserDefaults.standard.value(forKey: "cartCount") as? Int else {return 0}
        return userValue
    }
    
    static func getFullName() -> String {
        guard let userValue =  UserDefaults.standard.value(forKey: "full_name") as? String else {return ""}
        return userValue
    }
    
    static func getUserId() -> String {
        guard let userValue =  UserDefaults.standard.value(forKey: "User_id") as? String else {return ""}
        return userValue
    }
    
    static func getEmail() -> String {
        guard let userValue =  UserDefaults.standard.value(forKey: "email") as? String else {return ""}
        return userValue
    }
    
    static func getPhone() -> String {
        guard let userValue =  UserDefaults.standard.value(forKey: "phone") as? String else {return ""}
        return userValue
    }
    
    
    static func getIsUserLogin() -> Bool {
        guard let userValue =  UserDefaults.standard.value(forKey: "isUserLogin") as? Bool else {return false}
        return userValue
    }
    
    
    
    static func getIsActive() -> String {
        guard let userValue =  UserDefaults.standard.value(forKey: "active") as? String else {return ""}
        return userValue
    }
    
    static func getUserType() -> String {
        guard let userValue =  UserDefaults.standard.value(forKey: "user_type") as? String else {return ""}
        return userValue
    }
    

    
    static func getDiscountAllowed() -> String {
        guard let userValue =  UserDefaults.standard.value(forKey: "discount_allowed") as? String else {return ""}
        return userValue
    }
    
    
    
    
    static func getDiscountValue() -> String {
        guard let userValue =  UserDefaults.standard.value(forKey: "discount_value") as? String else {return ""}
        return userValue
    }
    
    
    
    //coupon_code
    
    static func getCouponCode() -> String {
        guard let userValue =  UserDefaults.standard.value(forKey: "coupon_code") as? String else {return ""}
        return userValue
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //=============================================================================================
    
    
    // UserDefaults.standard.removeObject(forKey: "apiToken")
    
    
    static func removeAllUserDefault()
    {
        
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            if key != "FMCToken"{
                defaults.removeObject(forKey: key)
                print("delete \(key)")
            }
        }
        
    }
    
    
}
