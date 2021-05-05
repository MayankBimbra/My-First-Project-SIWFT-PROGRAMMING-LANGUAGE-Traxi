//
//  DriverDeliveriesAPI.swift
//  Traxi
//
//  Created by IOS on 09/04/21.
//

import Foundation

// MARK: - DriverDeliveriesAPI
struct DriverDeliveriesAPI: Codable {
    let count: Int?
    let deliveries: [Delivery]
}

// MARK: - Delivery
struct Delivery: Codable {
    let id, jobType, deliverTypeID: Int?
    let storeID, name, image, address: String?
    let lng, lat: Double?
    let pickupTime: String?
    let storeRatings, driverID: Int?
    let deliveredCharges, taxCharges: Double?
    let timeSensitive: Int?
    let estimatedDeliveryTime, estimatedDeliveryMinute, estimatedDeliveryTimeReturn, estimatedDeliveryReturnMinute: String?
    let deliveryStatus: Int?
    let orderStatus: Int?
    let createdAt: String
    let itemCount: Int
    let distance: Double?
    let pickupDetails: [PickupDetail]?
    let dropoffDetails: [DropoffDetail]?

    enum CodingKeys: String, CodingKey {
        case id
        case jobType = "job_type"
        case deliverTypeID = "deliver_type_id"
        case storeID = "store_id"
        case name, image, address, lng, lat
        case pickupTime = "pickup_time"
        case storeRatings = "store_ratings"
        case driverID = "driver_id"
        case deliveredCharges = "delivered_charges"
        case taxCharges = "tax_charges"
        case timeSensitive = "time_sensitive"
        case estimatedDeliveryTime = "estimated_delivery_time"
        case estimatedDeliveryMinute = "estimated_delivery_minute"
        case estimatedDeliveryTimeReturn = "estimated_delivery_time_return"
        case estimatedDeliveryReturnMinute = "estimated_delivery_return_minute"
        case deliveryStatus = "delivery_status"
        case orderStatus = "order_status"
        case createdAt = "created_at"
        case itemCount = "item_count"
        case distance, pickupDetails, dropoffDetails
    }
}

// MARK: - DropoffDetail
struct DropoffDetail: Codable {
    let id: Int?
    let address, userName, userPhone, userApartment: String?
    let userLandmark: String?
    let lat, lng: Double?
    let deliveredAt: String?
    let distance: Double?

    enum CodingKeys: String, CodingKey {
        case id, address
        case userName = "user_name"
        case userPhone = "user_phone"
        case userApartment = "user_apartment"
        case userLandmark = "user_landmark"
        case lat, lng
        case deliveredAt = "delivered_at"
        case distance
    }
}

// MARK: - PickupDetail
struct PickupDetail: Codable {
    let id: Int?
    let pickup, pickupDate, pickupTime, address: String?
    let userName, userPhone, userApartment, userLandmark: String?
    let lat, lng: Double?
    let pickedUpAt: String?

    enum CodingKeys: String, CodingKey {
        case id, pickup
        case pickupDate = "pickup_date"
        case pickupTime = "pickup_time"
        case address
        case userName = "user_name"
        case userPhone = "user_phone"
        case userApartment = "user_apartment"
        case userLandmark = "user_landmark"
        case lat, lng
        case pickedUpAt = "picked_up_at"
    }
}
