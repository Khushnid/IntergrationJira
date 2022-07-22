import Foundation
import AtlassianHelper

protocol JiraViewModelProtocol: AnyObject {
    func didUpdateHomePage()
    func didAddNewTask()
}

class JiraViewModel {
    var userValues: (user: String, password: String, url: String, key: String)
    weak var delegate: JiraViewModelProtocol?
    fileprivate(set) var tasks: [JiraIssue] = []
    
    init(userValues: (user: String, password: String, url: String, key: String)) {
        self.userValues = userValues
    }
    
    lazy var networkManager = DefaultJiraManager(user: userValues.user,
                                                 password: userValues.password,
                                                 url: userValues.url,
                                                 projectKey: userValues.key)
    
    func fetchHomePage() {
        networkManager.fetchTasks { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.tasks = response.issues ?? []
                self.delegate?.didUpdateHomePage()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func addNewTask(summary: String, description: String) {
        networkManager.postTask(projectKey: userValues.key, summary: summary, description: description) { [weak self] result in
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
