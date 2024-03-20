import Foundation

class CartViewModel: ObservableObject {
    
    @Published var products : [Product] = []
    
//    
//    init(){
//        getCartData()
//    }
    
    func createCart(userID: String, productID: String, size: String, completion: @escaping (Result<CartModel, Error>) -> Void) {
        guard let url = URL(string: BaseUrl + "cart/") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let cartData: [String: Any] = [
            "userId": userID,
            "products": [
                [
                    "productId": productID,
                    "size": size
                ]
            ]
        ]
        
        print("cartData->",cartData)
        
        guard let jsonData = try? JSONSerialization.data(withJSONObject: cartData) else {
            completion(.failure(NSError(domain: "Failed to serialize data", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? NSError(domain: "Unknown error", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let cartModel = try JSONDecoder().decode(CartModel.self, from: data)
                completion(.success(cartModel))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
    func getCartData(completion: @escaping (Result<CartModel, Error>) -> Void) {
        guard let uid = UserDefaults.standard.string(forKey: "UID") else {
            completion(.failure(NSError(domain: "No UID found in UserDefaults", code: 0, userInfo: nil)))
            return
        }

        let urlString = BaseUrl + "cart/find/\(uid)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }

            do {
                
                let decoder = JSONDecoder()
                let cart = try decoder.decode(CartModel.self, from: data)
                self.products = cart.products

                completion(.success(cart))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }


}
