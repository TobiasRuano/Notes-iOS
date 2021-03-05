//
//  NetworkModel.swift
//  MoviesInfo
//
//  Created by Tobias Ruano on 04/04/2019.
//  Copyright © 2019 Tobias Ruano. All rights reserved.
//

import UIKit

enum DataType {
    case Token
    case User
    case Note
}

class NetworkManager {
    
    public static let shared = NetworkManager()
    let baseURL = "https://notes-app-ios.herokuapp.com/api/"
    var requestToken = ""
    
    let cache = NSCache<NSString, UIImage>()
    
    func logIn(mail: String, password: String, completed: @escaping (Result<(Token, User), MIError>) -> Void) {
        let endpoint = "\(baseURL)users/login/"
        let json = ["email": mail, "password": password]
        request(endpoint, nil, json) { (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let token = try decoder.decode(Token.self, from: data, keyPath: "loginUser")
                    do {
                        let user = try decoder.decode(User.self, from: data, keyPath: "loginUser.user")
                        completed(.success((token, user)))
                    } catch {
                        completed(.failure(.unableToParseData))
                    }
                } catch {
                    completed(.failure(.unableToParseData))
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getNotes(user: User, token: Token, completed: @escaping (Result<[Note], MIError>) -> Void) {
        let endpoint = "\(baseURL)notes/getnotes"
        #warning("Fix force unwraping")
        let json = ["userEmail": user.email!]
        request(endpoint, token.token, json) { (result) in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    #warning("Correct this!")
                    let notes = try decoder.decode([Note].self, from: data, keyPath: "data.docs")
                    completed(.success(notes))
                } catch {
                    completed(.failure(.unableToParseData))
                }
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
    
    private func request(_ endpoint: String, _ token: String?, _ json: [String: String], completed: @escaping (Result<Data, MIError>) -> Void) {
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUrl))
            return
        }
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        if let token = token {
            request.setValue(token, forHTTPHeaderField: "x-access-token")
        }
        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            completed(.success(data))
        })
        task.resume()
    }
}

extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data, keyPath: String) throws -> T {
        let toplevel = try JSONSerialization.jsonObject(with: data)
        if let nestedJson = (toplevel as AnyObject).value(forKeyPath: keyPath) {
            let nestedJsonData = try JSONSerialization.data(withJSONObject: nestedJson)
            return try decode(type, from: nestedJsonData)
        } else {
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Nested json not found for key path \"\(keyPath)\""))
        }
    }
}
