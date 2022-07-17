//
//  NetworkManager.swift
//  IntergrationJira
//
//  Created by Khushnid Ch on 17/07/22.
//

import Foundation

protocol Networkable {
    func fetchTasks(completion: @escaping (Result<Tasks, Error>) -> ())
    func postTask(completion: @escaping (Result<TaskResponse, Error>) -> ())
}
