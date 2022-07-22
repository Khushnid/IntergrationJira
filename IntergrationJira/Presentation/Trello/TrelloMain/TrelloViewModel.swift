import AtlassianHelper

protocol TrelloViewModelProtocol: AnyObject {
    func didUpdatePage()
}

class TrelloViewModel {
    weak var delegate: TrelloViewModelProtocol?
    lazy var networkManager = DefaultTrelloManager(key: userValues.key, token: userValues.token)
    
    var userValues: (key: String, token: String)
    var trelloData: (boardID: String, listID: String) = ("", "")
    var data: [TrelloResponse] = []
   
    init(userValues: (key: String, token: String)) {
        self.userValues = userValues
    }
}

extension TrelloViewModel {
    func fetchBoards() {
        networkManager.fetchBoards { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.data = response
                self.delegate?.didUpdatePage()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchLists() {
        networkManager.fetchLists(boardID: trelloData.boardID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.data = response
                self.delegate?.didUpdatePage()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchCards() {
        networkManager.fetchCards(listID: trelloData.listID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.data = response
                self.delegate?.didUpdatePage()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
