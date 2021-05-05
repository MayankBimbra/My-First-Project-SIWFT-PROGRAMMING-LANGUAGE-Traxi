//
//  GetOrderDetailsAPI.swift
//  Traxi
//
//  Created by IOS on 14/04/21.
//

import Foundation

// MARK: - GetOrderDetailsAPI
struct GetOrderDetailsAPI: Codable {
    let id: Int?
    let driverID: Int?
    let deliverTypeID, userRated: Int?
    let deliveredCharges, taxCharges: Double?
    let timeSensitive: Int?
    let estimatedDeliveryTime, estimatedDeliveryMinute, estimatedDeliveryReturnMinute: String?
    let lat, lng: Double?
    let estimatedDeliveryTimeReturn: String?
    let deliveryStatus: Int?
    let message: String?
    let userRatings: Int?
    let userReviews, userID: Int?
    let userName: String?
    let userProfileImage: String?
    let distanceTravelled: String?
    let duration, driverName, profileImage: String?
    let driverToUserRatings: Int?
    let pickupDetails, dropoffDetails: [Detail]
    let deliveryPackage: [DeliveryPackage]

    enum CodingKeys: String, CodingKey {
        case id
        case driverID = "driver_id"
        case deliverTypeID = "deliver_type_id"
        case userRated = "user_rated"
        case deliveredCharges = "delivered_charges"
        case taxCharges = "tax_charges"
        case timeSensitive = "time_sensitive"
        case estimatedDeliveryTime = "estimated_delivery_time"
        case estimatedDeliveryMinute = "estimated_delivery_minute"
        case estimatedDeliveryReturnMinute = "estimated_delivery_return_minute"
        case lat, lng
        case estimatedDeliveryTimeReturn = "estimated_delivery_time_return"
        case deliveryStatus = "delivery_status"
        case message
        case userRatings = "user_ratings"
        case userReviews = "user_reviews"
        case userID = "user_id"
        case userName = "user_name"
        case userProfileImage = "user_profile_image"
        case distanceTravelled = "distance_travelled"
        case duration
        case driverToUserRatings = "driver_to_user_ratings"
        case driverName = "driver_name"
        case profileImage = "profile_image"
        case pickupDetails, dropoffDetails, deliveryPackage
    }
}

// MARK: - DeliveryPackage
struct DeliveryPackage: Codable {
    let id: Int?
    let name: String?
}

// MARK: - Detail
struct Detail: Codable {
    let id: Int?
    let address, userName, userPhone, userApartment: String?
    let userLandmark: String?
    let distanceTravelled: Double?
    let lat, lng: Double
    let cancelledReason: Int?
    let packageImage: String?
    let distance: Double?
    let pickedUpAt: String?
    let deliveredAt: String?
    let cancelledAt, driverReachedAt: String?
    let pickup, pickupDate, pickupTime: String?

    enum CodingKeys: String, CodingKey {
        case id, address
        case userName = "user_name"
        case userPhone = "user_phone"
        case userApartment = "user_apartment"
        case userLandmark = "user_landmark"
        case distanceTravelled = "distance_travelled"
        case lat, lng
        case cancelledReason = "cancelled_reason"
        case packageImage = "package_image"
        case distance
        case pickedUpAt = "picked_up_at"
        case deliveredAt = "delivered_at"
        case cancelledAt = "cancelled_at"
        case driverReachedAt = "driver_reached_at"
        case pickup
        case pickupDate = "pickup_date"
        case pickupTime = "pickup_time"
    }
}
