//
//  CartViewModel.swift
//  ios-clothing-app
//
//

import Foundation


struct CartModel: Codable {
        let userID: String?
        let products: [Product]
        let id, createdAt, updatedAt: String
        let v: Int

        enum CodingKeys: String, CodingKey {
            case userID = ""
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


var sampleData: [CartModel] = [
    .init(userID: "qwerthbhw2624",
          products: [
            Product(productID: "1234",
                    quantity: 1,
                    title: "Sample Product",
                    desc: "Sample Product Description",
                    img: "sample_image.jpg",
                    categories: ["Category"],
                    size: "M",
                    color: ["Red"],
                    price: 100,
                    inStock: true,
                    id: "abcd1234")
          ],
          id: "abcd1234",
          createdAt: "2024-03-20T00:00:00Z",
          updatedAt: "2024-03-20T00:00:00Z",
          v: 1),
    .init(userID: "qwerthbhw2624",
          products: [
            Product(productID: "1234",
                    quantity: 1,
                    title: "new Product",
                    desc: "Sample Product Description",
                    img: "sample_image.jpg",
                    categories: ["Category"],
                    size: "M",
                    color: ["Red"],
                    price: 100,
                    inStock: true,
                    id: "abcd1234")
          ],
          id: "abcd1234",
          createdAt: "2024-03-20T00:00:00Z",
          updatedAt: "2024-03-20T00:00:00Z",
          v: 1)
    
]
