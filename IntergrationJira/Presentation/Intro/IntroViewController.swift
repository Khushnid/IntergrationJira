import UIKit

class IntroViewController: UITableViewController {
    let rows = ["Jira", "Trello"]

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IntroCell") else { return UITableViewCell()}
        cell.textLabel?.text = rows[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let navigation = self.storyboard?.instantiateViewController(withIdentifier: "JiraUser") as! JiraUserController
            self.navigationController?.pushViewController(navigation, animated: true)
        } else {
            let navigation = self.storyboard?.instantiateViewController(withIdentifier: "TrelloUser") as! TrelloUserController
            self.navigationController?.pushViewController(navigation, animated: true)
        }
    }
}
