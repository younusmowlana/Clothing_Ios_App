import Foundation
import SwiftUI
import Combine

class CartViewModel: ObservableObject {
    
    var compose = Set<AnyCancellable>()
    
    @Published var products: [CartModel] = []

    
    

    init(){
        getCartData()
    }
    
    func createCart(userID: String, productID: String, size: String, completion: @escaping (Result<CartModel, Error>) -> Void) {
        guard let url = URL(string: BaseUrl + "cart/") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        let cartData: [String: Any] = [
            "userId": userID,
            "productId": productID,
            "size": size
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
    

    func getCartData() {
        if let userID = UserDefaults.standard.string(forKey: "UID") {
            print("Younus->",userID)
            let urlString = BaseUrl + "cart/find/\(userID)"
            
            
            guard let url = URL(string: urlString) else { return }
            
            var request = URLRequest(url: url)
            
            print("request->",request)
            
            let session = URLSession(configuration: .default)
            
            print("1")
            
            session.dataTaskPublisher(for: request)
                .map(\.data)
                .retry(3)
                .decode(type: [CartModel].self, decoder: JSONDecoder())
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    switch completion {
                        
                    case .finished:
                        break
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }, receiveValue: { products in
                    self.products = products
                })
                .store(in: &compose)
        }
        else{
            print("Failed to retrieve userID from UserDefaults")
        }
    }


}
