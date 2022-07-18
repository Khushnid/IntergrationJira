//
//  HomeViewModel.swift
//  IntergrationJira
//
//  Created by Khushnid Ch on 17/07/22.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    func didUpdateHomePage()
    func didAddNewTask()
}

class HomeViewModel {
    weak var delegate: HomeViewModelProtocol?
    private let networkManager: NetworkManager
    
    fileprivate(set) var tasks: [Issue] = []
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchHomePage() {
        networkManager.fetchTasks { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.tasks = response.issues
                self.delegate?.didUpdateHomePage()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func addNewTask(summary: String, description: String) {
        networkManager.postTask(summary: summary, description: description) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                print(response.taskResponse)
                self.delegate?.didAddNewTask()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
