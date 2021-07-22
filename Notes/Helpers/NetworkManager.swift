//
//  NetworkModel.swift
//  MoviesInfo
//
//  Created by Tobias Ruano on 04/04/2019.
//  Copyright © 2019 Tobias Ruano. All rights reserved.
//

import UIKit

class NetworkManager {
    
    public static let shared = NetworkManager()
    let baseURL = "https://notes-app-ios.herokuapp.com/"
    var requestToken = Token()
    
    func logIn(mail: String, password: String, completed: @escaping (Result<User, MIError>) -> Void) {
        let endpoint = "\(baseURL)login/"
        let json = ["mail": mail, "password": password]
        request(endpoint, nil, json, httpMethod: "POST") { (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let token = try decoder.decode(Token.self, from: data, keyPath: "data")
                    do {
                        let user = try decoder.decode(User.self, from: data, keyPath: "data.User")
                        #warning("Fix this!")
                        self.requestToken = token
                        let userDefaults = UserDefaults.standard
                        userDefaults.set(self.requestToken.token, forKey: "token")
                        completed(.success(user))
                    } catch {
                        completed(.failure(.unableToParseData))
                    }
                } catch {
                    completed(.failure(.unableToParseData))
                }
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
    
    func registerUser(user: User, password: String, completed: @escaping (Result<User, MIError>) -> Void) {
        let endpoint = "\(baseURL)user/sign-up"
        let json = ["name": user.name!, "surname": user.surname!, "mail": user.mail!, "password": password]
        request(endpoint, nil, json, httpMethod: "POST") { (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let user = try decoder.decode(User.self, from: data, keyPath: "User")
                    completed(.success(user))
                } catch {
                    completed(.failure(.unableToParseData))
                }
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
    
    func getNotes(completed: @escaping (Result<[Note], MIError>) -> Void) {
        let endpoint = "\(baseURL)user/getnotes"
        request(endpoint, requestToken.token, nil, httpMethod: "POST") { (result) in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let notes = try decoder.decode([Note].self, from: data, keyPath: "data")
                    completed(.success(notes))
                } catch {
                    completed(.failure(.unableToParseData))
                }
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
    
    func saveNote(note: Note, completed: @escaping (Result<Note, MIError>) -> Void) {
        let endpoint = "\(baseURL)user/"
        var json = ["title": note.title!, "content": note.content!]
        if let id = note.id {
            json["id"] = String(id)
        }
        request(endpoint, requestToken.token, json, httpMethod: "POST") { (result) in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let note = try decoder.decode(Note.self, from: data, keyPath: "Note")
                    completed(.success(note))
                } catch {
                    completed(.failure(.unableToParseData))
                }
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
    
    func deleteNote(note: Note, completed: @escaping (Result<String, MIError>) -> Void) {
        let endpoint = "\(baseURL)user/"
        var json = [String:String]()
        if let id = note.id {
            json["id"] = String(id)
        }
        request(endpoint, requestToken.token, json, httpMethod: "DELETE") { (result) in
            switch result {
            case .success(_):
                completed(.success("success"))
            case .failure(let error):
                completed(.failure(error))
            }
        }
    }
    
    private func request(_ endpoint: String, _ token: String?, _ json: [String: String]?, httpMethod: String, completed: @escaping (Result<Data, MIError>) -> Void) {
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUrl))
            return
        }
        
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        if let token = token {
            request.setValue( "Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        request.httpMethod = httpMethod
        
        if let json = json {
            let jsonData = try? JSONSerialization.data(withJSONObject: json)
            request.httpBody = jsonData
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode < 300 else {
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
