import Foundation

class CartViewModel: ObservableObject {
    
    func createCart(userID: String, productID: String, size: String, completion: @escaping (Result<CartModel, Error>) -> Void) {
        guard let url = URL(string: BaseUrl + "cart/") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        // Create the request body
        let cartData: [String: Any] = [
            "userId": userID,
            "products": [
                [
                    "productId": productID,
                    "size": size
                ]
            ]
        ]
        
        // Convert the data to JSON
        guard let jsonData = try? JSONSerialization.data(withJSONObject: cartData) else {
            completion(.failure(NSError(domain: "Failed to serialize data", code: 0, userInfo: nil)))
            return
        }
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        // Perform the request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "Unknown error", code: 0, userInfo: nil)))
                return
            }
            
            // Parse the response
            do {
                let cartModel = try JSONDecoder().decode(CartModel.self, from: data)
                completion(.success(cartModel))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
