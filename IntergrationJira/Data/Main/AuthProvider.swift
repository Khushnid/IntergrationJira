//
//  AuthProvider.swift
//  IntergrationJira
//
//  Created by Khushnid Ch on 17/07/22.
//

import Moya

class AuthProvider {

    static let basicAuthPlugin: PluginType = AccessTokenPlugin(tokenClosure: { _ -> String in
        let username = "xushnudbek321@gmail.com"
        let password = "smW3YjPvVtLzf9ZAQbFF7F6F"
        guard let loginData = String(format: "\(username):\(password)").data(using: .utf8) else { return "" }
        return loginData.base64EncodedString()
    })
}
