//
//  ViewController.swift
//  IntergrationJira
//
//  Created by Khushnid Ch on 15/07/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchHomePage()
    }
    
    
    func fetchHomePage() {
        networkManager.fetchTasks { result in
            switch result {
            case .success(let response):
                print(response)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

