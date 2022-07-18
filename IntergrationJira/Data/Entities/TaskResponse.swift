//
//  TaskResponse.swift
//  IntergrationJira
//
//  Created by Khushnid Ch on 17/07/22.
//

import Foundation

struct TaskResponse: Codable {
    let id, key: String
    let taskResponse: String

    enum CodingKeys: String, CodingKey {
        case id, key
        case taskResponse = "self"
    }
}
