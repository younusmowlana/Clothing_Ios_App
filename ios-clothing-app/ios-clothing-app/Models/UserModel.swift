//
//  UserModel.swift
//  ios-clothing-app
//
//  Created by Kabir Moulana on 3/12/24.
//

import Foundation
struct UserModel: Codable {
    let username, email, password: String
    let isAdmin: Bool
    let id, createdAt, updatedAt: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case username, email, password, isAdmin
        case id = "_id"
        case createdAt, updatedAt
        case v = "__v"
    }
}
