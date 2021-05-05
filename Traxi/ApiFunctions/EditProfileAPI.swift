//
//  editProfileAPI.swift
//  Traxi
//
//  Created by IOS on 31/03/21.
//

import Foundation

// MARK: - EditProfileAPI
struct EditProfileAPI: Codable {
    let message: String?
}

// MARK: - UploadImageAPI
struct UploadImageAPI: Codable {
    let message, filename: String?
}

