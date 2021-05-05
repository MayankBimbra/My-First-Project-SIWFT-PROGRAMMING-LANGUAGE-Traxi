//
//  GetDriverTransactionsAPI.swift
//  Traxi
//
//  Created by mac1 on 29/04/21.
//

import Foundation

// MARK: - GetDriverTransactionsAPIElement
struct GetDriverTransactionsAPIElement: Codable {
    let walletID, deliveryID: Int?
    let name: String?
    let amount: Double?
    let createdAt: String?
    let jobType: Int?
    let status: String?

    enum CodingKeys: String, CodingKey {
        case walletID = "wallet_id"
        case deliveryID = "delivery_id"
        case name, amount
        case createdAt = "created_at"
        case jobType = "job_type"
        case status
    }
}

enum Name: String, Codable {
    case aman = "Aman"
    case mayankBimbra = "Mayank Bimbra"
    case sonam = "sonam"
}

enum Status: String, Codable {
    case delivery = "Delivery"
}

typealias GetDriverTransactionsAPI = [GetDriverTransactionsAPIElement]
