//
//  CartViewModel.swift
//  ios-clothing-app
//
//

import Foundation


struct CartModel: Codable {
        let userID: String
        let products: [Product]
        let id, createdAt, updatedAt: String
        let v: Int

        enum CodingKeys: String, CodingKey {
            case userID = "userId"
            case products
            case id = "_id"
            case createdAt, updatedAt
            case v = "__v"
        }
    }

    // MARK: - Product
    struct Product: Codable {
        let productID: String
        let quantity: Int
        let title, desc: String
        let img: String
        let categories: [String]
        let size: String
        let color: [String]
        let price: Int
        let inStock: Bool
        let id: String

        enum CodingKeys: String, CodingKey {
            case productID = "productId"
            case quantity, title, desc, img, categories, size, color, price, inStock
            case id = "_id"
        }
    }
