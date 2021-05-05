//
//  LoginAPI.swift
//  Traxi
//
//  Created by IOS on 24/03/21.
//

import Foundation

// MARK: - LoginAPI
struct LoginAPI: Codable {
    let message, token: String?
    let user: User?
    let update: Int?
}

// MARK: - User
struct User: Codable {
    let id: Int?
    let name, profileImage, email, countryCode: String?
    let phone: Int?
    let lat, lng: Double?
    let fcmID, deviceID: String?
    let deviceType: Int?
    let resetPassToken, emailVerifyToken: String?
    let phoneVerificationOtp: Int?
    let isEmailVerified, isPhoneVerifed: Int?
    let isDeactivated: Int?
    let stripeCustomerID: String?
    let deactivateReason: String?
    let vehicleNo, licenseNo: String?
    let vehicleImage: String?
    let licenseImage, vehicleName: String?
    let stripeAccountID, dob, expiredAt: String?
    let createdAt, updatedAt: String?
    let walletBalance: Double?

    enum CodingKeys: String, CodingKey {
        case id, name
        case profileImage = "profile_image"
        case email
        case countryCode = "country_code"
        case phone, lat, lng
        case fcmID = "fcm_id"
        case deviceID = "device_id"
        case deviceType = "device_type"
        case resetPassToken = "reset_pass_token"
        case emailVerifyToken = "email_verify_token"
        case phoneVerificationOtp = "phone_verification_otp"
        case isEmailVerified = "is_email_verified"
        case isPhoneVerifed = "is_phone_verifed"
        case isDeactivated = "is_deactivated"
        case stripeCustomerID = "stripe_customer_id"
        case deactivateReason = "deactivate_reason"
        case vehicleNo = "vehicle_no"
        case licenseNo = "license_no"
        case vehicleImage = "vehicle_image"
        case licenseImage = "license_Image"
        case vehicleName = "vehicle_name"
        case stripeAccountID = "stripe_account_id"
        case dob
        case expiredAt = "expired_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case walletBalance = "wallet_balance"
    }
}

