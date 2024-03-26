import Foundation

// MARK: - WelcomeElement
struct CartModel: Codable {
    let id, userID, productID, title: String
    let desc, img: String
    let categories: [String]
    let size: String
    let color: [String]
    let price, quantity: Int

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case userID = "userId"
        case productID = "productId"
        case title, desc, img, categories, size, color, price, quantity
    }
}
