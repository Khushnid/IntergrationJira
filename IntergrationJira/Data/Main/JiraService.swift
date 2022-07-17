//
//  JiraService.swift
//  IntergrationJira
//
//  Created by Khushnid Ch on 17/07/22.
//

import Foundation
import Moya

enum JiraService {
    case fetchTasks
    case postTask
}

extension JiraService: TargetType {
    
    var baseURL: URL {
        URL(string: "https://khushnidjon.atlassian.net/")!
    }
    
    var path: String {
        switch self {
        case .fetchTasks:
            return "rest/api/3/search"
        case .postTask:
            return "rest/api/3/issue"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetchTasks:
            return .get
        case .postTask:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        switch self {
        case .fetchTasks, .postTask:
            return ["Content-Type" : "application/json"]
        }
    }
}
