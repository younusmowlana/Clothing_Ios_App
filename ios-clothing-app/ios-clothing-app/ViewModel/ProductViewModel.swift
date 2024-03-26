import Foundation
import SwiftUI
import Combine

class ProductViewModel : ObservableObject{
    
    var compose = Set<AnyCancellable>()
    
    @Published var products :[ProductModel] = []
    
    init(){
        loadDataCombine()
    }
    
    func loadDataCombine(){
        let urlString = BaseUrl + "product";
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        
        let session = URLSession(configuration: .default)
        
        print("product fetch")
        session.dataTaskPublisher(for: request)
            .map(\.data)
            .retry(3)
            .decode(type: [ProductModel].self, decoder: JSONDecoder())
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
}
