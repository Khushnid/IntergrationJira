import UIKit

class TrelloController: UIViewController {
    @IBOutlet weak var tasksTable: UITableView!
    let refreshControl = UIRefreshControl()
    
    var userValues: (key: String, token: String) = ("", "")
    private lazy var viewModel = TrelloViewModel(userValues: userValues)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        viewModel.delegate = self
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tasksTable.addSubview(refreshControl)
    }
}

extension TrelloController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell") else { return UITableViewCell()}
        cell.textLabel?.text = "Random One"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}

extension TrelloController {
    @objc func refresh() {
        
    }
}

extension TrelloController: TrelloViewModelProtocol {
  
}
