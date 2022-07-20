import Foundation
import AtlassianHelper

protocol JiraViewModelProtocol: AnyObject {
    func didUpdateHomePage()
    func didAddNewTask()
}

class JiraViewModel {
    weak var delegate: JiraViewModelProtocol?
    fileprivate(set) var tasks: [JiraIssue] = []
    
    let networkManager = DefaultJiraManager(user: "xushnudbek321@gmail.com",
                                            password: "smW3YjPvVtLzf9ZAQbFF7F6F",
                                            url: "https://khushnidjon.atlassian.net",
                                            projectKey: "PPOKERMAIN")

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
