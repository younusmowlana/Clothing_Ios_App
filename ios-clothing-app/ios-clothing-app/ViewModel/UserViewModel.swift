//
//  UserViewModel.swift
//  ios-clothing-app
//
//

import Foundation
import SwiftUI
import Combine

class UserViewModel: ObservableObject {
    
    var compose = Set<AnyCancellable>()
    
    @Published var userDetails: [UserModel] = []

    @State private var isLoading = true
        

    init(){
        getUserData()
    }
    
    func registerUser(username: String,email: String, password: String,  completion: @escaping (Result<UserModel, Error>) -> Void) {
        guard let url = URL(string: BaseUrl + "auth/register") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: Any] = [
            "username": username,
            "password": password,
            "email": email
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData

            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else {
                    completion(.failure(error ?? NSError(domain: "No data received", code: 0, userInfo: nil)))
                    return
                }

                do {
                    let user = try JSONDecoder().decode(UserModel.self, from: data)
                    completion(.success(user))
                } catch {
                    completion(.failure(error))
                }
            }

            task.resume()
        } catch {
            completion(.failure(error))
        }
    }

func loginUser(username: String, password: String, completion: @escaping (Result<UserModel, Error>) -> Void) {
        guard let url = URL(string: BaseUrl + "auth/login") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: Any] = [
            "username": username,
            "password": password
        ]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData

            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data else {
                    completion(.failure(error ?? NSError(domain: "No data received", code: 0, userInfo: nil)))
                    return
                }

                do {
                    let user = try JSONDecoder().decode(UserModel.self, from: data)
                    completion(.success(user))
                } catch {
                    completion(.failure(error))
                }
            }

            task.resume()
        } catch {
            completion(.failure(error))
        }
    }
    
    
    //GET USER DETAILS
    func getUserData() {
        if let userID = UserDefaults.standard.string(forKey: "UID") {
            let urlString = BaseUrl + "user/find/\(userID)"
            
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
                        print("Data Recived \(json)")
                        self.isLoading = false
                        
                        let decodedData = try JSONDecoder().decode([UserModel].self, from: data)
                        DispatchQueue.main.async {
                            self.userDetails = decodedData
                        }
                    } catch {
                        print("Error decoding data: \(error)")
                        self.isLoading = false
                    }
                })
                .store(in: &compose)
        } else {
            print("Failed to retrieve userID from UserDefaults")
        }
    }

    
}
