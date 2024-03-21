import Foundation

// MARK: - Welcome
struct CartModel: Codable {
    let userID, productID: String?
    let quantity: Int
    let title, desc, img: String
    let categories: [String]
    let size: String
    let color: [String]
    let price: Int
    let inStock: Bool
    let id, createdAt, updatedAt: String
    let v: Int

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case productID = "productId"
        case quantity, title, desc, img, categories, size, color, price, inStock
        case id = "_id"
        case createdAt, updatedAt
        case v = "__v"
    }
}
