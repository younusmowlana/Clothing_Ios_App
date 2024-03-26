import Foundation
import SwiftUI
import Combine

class CartViewModel: ObservableObject {
    
    var compose = Set<AnyCancellable>()
    
    @Published var products: [CartModel] = []

//  @Published var isLoading: Bool = false
        

    init(){
        getCartData()
    }
    
    func createCart(userID: String, productID: String, size: String) {
        let urlString = BaseUrl + "cart/"
        
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "userId": userID,
            "productId": productID,
            "size": size
            
        ]

        print("paramiters->",parameters)
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Error encoding parameters: \(error)")
            return
        }
        
        let session = URLSession(configuration: .default)
        
        session.dataTaskPublisher(for: request)
            .map(\.data)
            .retry(3)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            }, receiveValue: { data in
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print("Response JSON: \(json)")
                    
                    // If you need to do something with the response, add code here
                    
                } catch {
                    print("Error decoding data: \(error)")
                }
            })
            .store(in: &compose)
    }


    func getCartData() {
        if let userID = UserDefaults.standard.string(forKey: "UID") {
            let urlString = BaseUrl + "cart/find/\(userID)"
            
            guard let url = URL(string: urlString) else { return }
            
            var request = URLRequest(url: url)
            print("request->",request)
            let session = URLSession(configuration: .default)
            
            session.dataTaskPublisher(for: request)
                .map(\.data)
                .retry(3)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print("Error: \(error)")
                    }
                }, receiveValue: { data in
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print("Response JSON: \(json)")
                        
                        let decodedData = try JSONDecoder().decode([CartModel].self, from: data)
                        DispatchQueue.main.async {
                            self.products = decodedData
                        }
                    } catch {
                        print("Error decoding data: \(error)")
                    }
                })
                .store(in: &compose)
        } else {
            print("Failed to retrieve userID from UserDefaults")
        }
    }
    

}
