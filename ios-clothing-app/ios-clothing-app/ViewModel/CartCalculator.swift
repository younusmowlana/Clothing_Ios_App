//
//  CartCalculator.swift
//  ios-clothing-app
//
//
//
//import Foundation
//
//class CartCalculator: ObservableObject {
//    @Published var totalAmount: Int = 0
//    @Published var products: [CartModel] = []
//
//    init(products: [CartModel]) {
//        self.products = products
//        calculateTotalAmount()
//    }
//
//    func calculateTotalAmount() {
//        totalAmount = products.reduce(0) { $0 + $1.price * $1.quantity }
//    }
//
//    func updateQuantity(for product: CartModel, increase: Bool) {
//        if let index = products.firstIndex(where: { $0.id == product.id }) {
//            if increase {
//                products[index].quantity += 1
//            } else {
//                products[index].quantity -= 1
//                if products[index].quantity <= 0 {
//                    products.remove(at: index)
//                }
//            }
//            calculateTotalAmount()
//        }
//    }
//}
