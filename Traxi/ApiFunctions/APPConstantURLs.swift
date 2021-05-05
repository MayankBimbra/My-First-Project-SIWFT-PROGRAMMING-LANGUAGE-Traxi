//
//  CommonAPIs.swift
//  Traxi
//
//  Created by IOS on 24/03/21.
//

import Foundation
import UIKit

class appConstantURL {
    
   // let BASE_URL = "https://app-transfer.com:3006/api/"
    let BASE_URL = "https://app-transfer.com:3001/api/"
    let signUpURL = "driver"
    let LoginURL = "driver/login"
    let forgotURL = "forgot/password"
    let editProfileURL = "driver"
    let logoutURL = "driver/logout"
    let uploadImageURL = "upload/aws"
    let getProfileURL = "aws/file?filename=1617187123890-apple.png&folder=small"
    let changePassowrdURL = "change/password"
    let contactUsURL = "driver/contact-us"
    let getDriverDeliveriesURL = "driver/deliveries"
    let deliveryAcceptedURL = "driver/accepted"
    let getOrderDetailsURL = "order"
    let driverManagementURL = "delivery/management"
    let getDriverTransactionsURL = "driver/transaction"
    let feedbackUser_DriverURL = "feedback"
    let WithdrawalURL = "driver/withdrawal"
    
    let resendPhoneVerifyURL = "resend/verification-phone"
    let verifyPhoneURL = "verify/phone"
    let resetNotificationsURL = "reset/notifications"
    let contentDataURL = "content"
  
    let emailVerifyURL = "resend/verification-email"
    
    let notificationAPI = "notification"
    let chatListingAPI = "chat/listing"
    let chatIntListingAPI = "chat/messages"
    
 
}

enum Image_Quality : String {
    case medium = "&folder=medium"
    case small = "&folder=small"
    case large = "&folder=orig"
}
