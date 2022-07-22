import UIKit

class TrelloController: UIViewController {
    @IBOutlet weak var tasksTable: UITableView!
    
    private lazy var viewModel = TrelloViewModel(userValues: userValues)
    var userValues: (key: String, token: String) = ("", "")
    var state: TrelloBoardState = .boards
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        viewModel.delegate = self
        viewModel.fetchBoards()
    }
}

extension TrelloController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TrelloCell") else { return UITableViewCell() }
        cell.textLabel?.text = viewModel.data[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if state != .cards {
            title = viewModel.data[indexPath.row].name
        }
      
        switch state {
        case .boards:
            if let boardID = viewModel.data[indexPath.row].id {
                state = .lists
                viewModel.trelloData.boardID = boardID
                viewModel.fetchLists()
                reloadList()
            }
        case .lists:
            if let listID = viewModel.data[indexPath.row].id {
                state = .cards
                viewModel.trelloData.listID = listID
                viewModel.fetchCards()
                reloadList()
            }
        case .cards:
            if let cardURL = viewModel.data[indexPath.row].url {
                if let url = URL(string: cardURL), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }
        }
    }
    
    private func reloadList() {
        viewModel.data = []
        tasksTable.reloadData()
    }
}

extension TrelloController: TrelloViewModelProtocol {
    func didUpdatePage() {
        tasksTable.reloadData()
    }
}
