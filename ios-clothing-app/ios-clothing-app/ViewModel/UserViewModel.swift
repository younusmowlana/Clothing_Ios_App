//
//  UserViewModel.swift
//  ios-clothing-app
//
//  Created by Kabir Moulana on 3/12/24.
//

import Foundation
import SwiftUI

class UserViewModel: ObservableObject {
    func registerUser(user: UserModel, completion: @escaping (Result<UserModel, Error>) -> Void) {
        guard let url = URL(string: BaseUrl + "auth/register") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let jsonData = try JSONEncoder().encode(user)
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
}
