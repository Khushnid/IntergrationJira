//
//  NetworkManagerProtocol.swift
//  IntergrationJira
//
//  Created by Khushnid Ch on 17/07/22.
//

import Moya
import UIKit

class NetworkManager: Networkable {
    
    var provider = MoyaProvider<JiraService>(plugins: [CredentialsPlugin { _ -> URLCredential? in
        let user = "xushnudbek321@gmail.com"
        let password = "smW3YjPvVtLzf9ZAQbFF7F6F"
        
        return URLCredential(user: user, password: password, persistence: .permanent)
    }])
    
    func fetchTasks(completion: @escaping (Result<Tasks, Error>) -> ()) {
        request(target: .fetchTasks, completion: completion)
    }
    
    func postTask(completion: @escaping (Result<TaskResponse, Error>) -> ()) {
        request(target: .postTask, completion: completion)
    }
}

private extension NetworkManager {
    private func request<T: Decodable>(target: JiraService, completion: @escaping (Result<T, Error>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(results))
                } catch let error {
                    completion(.failure(error))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
