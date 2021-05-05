//
//  CoreData.swift
//  Traxi
//
//  Created by IOS on 02/04/21.
//

import Foundation
import UIKit
import CoreData

class coreData: NSObject {
    
    var accessToken = ""
    var isPhoneVerified = 0
    
    var userId = 0
    var name = ""
    var profileImage = ""
    var email = ""
    var phoneNumber = 0
    var stripe_account_id = ""
    var wallet_balance = 0.0
    var stripe_customer_id = ""
//    var fbId = ""
//    var googleId = ""
//    var appleId = ""
    
    class var shared: coreData{
        struct singleTon {
            static let instance = coreData()
        }
        return singleTon.instance
    }
    
    func fromSignUpData(_ data: LoginAPI){
        accessToken = data.token ?? ""
        isPhoneVerified = data.user?.isPhoneVerifed ?? 0
        userId = data.user?.id ?? 0
        name = data.user?.name ?? ""
        profileImage = data.user?.profileImage ?? ""
        email = data.user?.email ?? ""
        phoneNumber = data.user?.phone ?? 0
        stripe_account_id = data.user?.stripeAccountID ?? ""
        wallet_balance = data.user?.walletBalance ?? 0
        stripe_customer_id = data.user?.stripeCustomerID ?? ""
        dataSave()
    }
    
    func dataSave(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "CoreData"))
        
        do {
            try context.execute(DelAllReqVar)
        } catch {
            print(error)
        }
        let newData = NSEntityDescription.insertNewObject(forEntityName: "CoreData", into: context)
        newData.setValue(accessToken, forKey: "token")
        newData.setValue(isPhoneVerified, forKey: "isPhoneVerified")
        newData.setValue(userId, forKey: "userId")
        newData.setValue(profileImage, forKey: "profileImage")
        newData.setValue(email, forKey: "email")
        newData.setValue(name, forKey: "name")
        newData.setValue(phoneNumber, forKey: "phoneNumber")
        newData.setValue(wallet_balance, forKey: "wallet_balance")
        newData.setValue(stripe_account_id, forKey: "stripe_account_id")
        newData.setValue(stripe_customer_id, forKey: "stripe_customer_id")
        do {
            try context.save()
            print(newData)
            print("new data saved")
        }catch{
            print("new data save error")
        }
    }
    
    
    func deleteData(){
        accessToken = ""
        profileImage = ""
        phoneNumber = 0
        name = ""
        isPhoneVerified = 0
        email = ""
        userId = 0
        stripe_customer_id = ""
        stripe_account_id = ""
        wallet_balance = 0
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let DelAllReqVar = NSBatchDeleteRequest(fetchRequest: NSFetchRequest<NSFetchRequestResult>(entityName: "CoreData"))
        do {
            try context.execute(DelAllReqVar)
        } catch {
            print(error)
        }
        self.dataSave()
    }
    
    func getData(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreData")
        request.returnsObjectsAsFaults = true
        do{
            let results = try context.fetch(request)
            if(results.count > 0){
                for result in results as![NSManagedObject]{
                    
                    if let accessToken = result.value(forKey: "token") as? String{
                        self.accessToken = accessToken
                        print("data get accessToken \(accessToken)")
                    }
                    if let isPhoneVerified = result.value(forKey: "isPhoneVerified") as? Int{
                        self.isPhoneVerified = isPhoneVerified
                        print("data get isPhoneVerified \(isPhoneVerified)")
                    }
                    if let userId = result.value(forKey: "userId") as? Int{
                        self.userId = userId
                        print("data get userId \(userId)")
                    }
                    if let name = result.value(forKey: "name") as? String{
                        self.name = name
                        print("data get name \(name)")
                    }
                    if let profileImage = result.value(forKey: "profileImage") as? String{
                        self.profileImage = profileImage
                        print("data get profileImage \(profileImage)")
                    }
                    if let email = result.value(forKey: "email") as? String{
                        self.email = email
                        print("data get email \(email)")
                    }
                    if let phoneNumber = result.value(forKey: "phoneNumber") as? Int{
                        self.phoneNumber = phoneNumber
                        print("data get phoneNumber \(phoneNumber)")
                    }
                    if let wallet_balance = result.value(forKey: "wallet_balance") as? Double{
                        self.wallet_balance = wallet_balance
                        print("data get walletBalance \(wallet_balance)")
                    }
                    if let stripe_customer_id = result.value(forKey: "stripe_customer_id") as? String{
                        self.stripe_customer_id = stripe_customer_id
                        print("data get stripeCustomerId \(stripe_customer_id)")
                    }
                    if let stripe_account_id = result.value(forKey: "stripe_account_id") as? String{
                        self.stripe_account_id = stripe_account_id
                        print("data get stripeAccountId \(stripe_account_id)")
                    }
                }
            }
        } catch {
            print("something error during getting data")
        }
    }
}
