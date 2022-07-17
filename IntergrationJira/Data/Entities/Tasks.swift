//
//  Tasks.swift
//  IntergrationJira
//
//  Created by Khushnid Ch on 17/07/22.
//

import Foundation

struct Tasks: Codable {
    let maxResults, total: Int
    let issues: [Issue]
}

// MARK: - Issue
struct Issue: Codable {
    let id: String
    let issueSelf: String
    let key: String
    let fields: IssueFields

    enum CodingKeys: String, CodingKey {
        case id, key, fields
        case issueSelf = "self"
    }
}

// MARK: - Fields
struct IssueFields: Codable {
    let created: String
    let summary: String
}
