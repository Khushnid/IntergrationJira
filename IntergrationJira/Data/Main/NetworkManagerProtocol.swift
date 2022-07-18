//
//  NetworkManagerProtocol.swift
//  IntergrationJira
//
//  Created by Khushnid Ch on 17/07/22.
//

import Foundation
import Moya

class NetworkManager: Networkable {
    
    var provider = MoyaProvider<JiraService>(plugins: [AuthProvider.basicAuthPlugin])
    
    func fetchTasks(completion: @escaping (Result<Tasks, Error>) -> ()) {
        request(target: .fetchTasks, completion: completion)
    }
    
    func postTask(summary: String, description: String, completion: @escaping (Result<TaskResponse, Error>) -> ()) {
        request(target: .postTask(summary: summary, description: description), completion: completion)
    }
    
    init(provider: MoyaProvider<JiraService>) {
        self.provider = provider
    }
    
    convenience init(){
        let networkActivityClosure: NetworkActivityPlugin.NetworkActivityClosure = {_,_ in}
        let networkActivityPlugin = NetworkActivityPlugin(networkActivityClosure: networkActivityClosure)
        let networkLogger = NetworkLoggerPlugin()
        var plugins : [PluginType] = []
        let provider = MoyaProvider<JiraService>(plugins: plugins)
        
        plugins.append(networkActivityPlugin)
        plugins.append(networkLogger)
        self.init(provider: provider)
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
