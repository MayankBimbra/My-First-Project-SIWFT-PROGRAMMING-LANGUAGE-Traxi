//
//  getProfileAPI.swift
//  Traxi
//
//  Created by IOS on 31/03/21.
//

import Foundation

// MARK: - GetProfileAPI
struct GetProfileAPI: Codable {
    let id: Int?
    let name, profileImage, email, countryCode: String?
    let phone: Int?
    let lat, lng: Double?
    let walletBalance: Int?
    let fcmID, deviceID: String?
    let deviceType, isEmailVerified, isPhoneVerifed: Int?
    let isDeactivated, stripeAccountID: String?
    let stripeCustomerID: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case profileImage = "profile_image"
        case email
        case countryCode = "country_code"
        case phone, lat, lng
        case walletBalance = "wallet_balance"
        case fcmID = "fcm_id"
        case deviceID = "device_id"
        case deviceType = "device_type"
        case isEmailVerified = "is_email_verified"
        case isPhoneVerifed = "is_phone_verifed"
        case isDeactivated = "is_deactivated"
        case stripeAccountID = "stripe_account_id"
        case stripeCustomerID = "stripe_customer_id"
    }
}


