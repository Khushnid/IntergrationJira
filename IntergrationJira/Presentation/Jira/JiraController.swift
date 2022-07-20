import UIKit

class JiraController: UIViewController {
    @IBOutlet weak var tasksTable: UITableView!
    let refreshControl = UIRefreshControl()

    private var viewModel = JiraViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.fetchHomePage()
        
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tasksTable.addSubview(refreshControl)
    }
    
}

extension JiraController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell") else { return UITableViewCell()}
        cell.textLabel?.text = viewModel.tasks[indexPath.row].fields?.summary
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(viewModel.tasks[indexPath.row].fields?.summary ?? "")
    }
}

extension JiraController {
    @objc func refresh() {
        viewModel.fetchHomePage()
    }
    
    @IBAction func JiraTask(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "New Task", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in textField.placeholder = "Summary" }
        alertController.addTextField { (textField : UITextField!) -> Void in textField.placeholder = "Description" }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: { (action : UIAlertAction!) -> Void in })
        
        let saveAction = UIAlertAction(title: "Add", style: UIAlertAction.Style.default, handler: { alert -> Void in
            self.viewModel.addNewTask(summary: alertController.textFields![0].text ?? "",
                                      description: alertController.textFields![1].text ?? "")
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension JiraController: JiraViewModelProtocol {
    func didAddNewTask() {
        viewModel.fetchHomePage()
    }
    
    func didUpdateHomePage() {
        tasksTable.reloadData()
        refreshControl.endRefreshing()
    }
}
