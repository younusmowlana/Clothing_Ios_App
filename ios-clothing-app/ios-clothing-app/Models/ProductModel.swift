//
//  ProductView.swift
//  ios-clothing-app
//
//

import Foundation
struct ProductModel: Codable {
    let id, title, desc: String
    let img: String
    let categories, size, color: [String]
    let price: Int
    let inStock: Bool
    let createdAt, updatedAt: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title, desc, img, categories, size, color, price, inStock, createdAt, updatedAt
        case v = "__v"
    }
}

