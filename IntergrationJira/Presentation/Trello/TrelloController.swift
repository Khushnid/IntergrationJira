import UIKit

class TrelloController: UIViewController {
    @IBOutlet weak var tasksTable: UITableView!
    
    var userValues: (key: String, token: String) = ("", "")
    private lazy var viewModel = TrelloViewModel(userValues: userValues)
    var shouldFetchLists: Bool = true
    
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
        title = viewModel.data[indexPath.row].name
    
        if shouldFetchLists {
            viewModel.trelloData.boardID = viewModel.data[indexPath.row].id ?? ""
            reloadList()
            viewModel.fetchLists()
        } else {
            viewModel.trelloData.listID = viewModel.data[indexPath.row].id ?? ""
            reloadList()
            viewModel.fetchCards()
        }
        
        shouldFetchLists = false
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
