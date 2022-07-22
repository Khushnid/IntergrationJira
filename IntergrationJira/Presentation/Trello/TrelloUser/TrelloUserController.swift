import UIKit

class TrelloUserController: UIViewController {
    @IBOutlet weak var keyField: UITextField!
    @IBOutlet weak var tokenField: UITextField!
    @IBOutlet weak var proceedButton: UIButton!
    let TRELLO_STORYBOARD_ID = "TrelloMain"
    
    var textValues: (key: String, token: String) = ("", "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keyField.delegate = self
        tokenField.delegate = self
        
        tokenField.addTarget(self, action: #selector(tokenFieldDidChange(_:)), for: .editingChanged)
        keyField.addTarget(self, action: #selector(keyFieldDidChange(_:)), for: .editingChanged)
      
        proceedButton.addTarget(self, action: #selector(proceedJiraScreen), for: .touchUpInside)
    }
    
    @objc func proceedJiraScreen() {
        let navigation = self.storyboard?.instantiateViewController(withIdentifier: TRELLO_STORYBOARD_ID) as! TrelloController
        navigation.userValues = textValues
        self.navigationController?.pushViewController(navigation, animated: true)
    }
}

extension TrelloUserController: UITextFieldDelegate {
    @objc func tokenFieldDidChange(_ textField: UITextField) {
        textValues.token = textField.text ?? ""
        buttonStatusSpy()
    }
    
    @objc func keyFieldDidChange(_ textField: UITextField) {
        textValues.key = textField.text ?? ""
        buttonStatusSpy()
    }
    
    private func buttonStatusSpy() {
        if (textValues.key != "" && textValues.key.count > 8
            && textValues.token != "" && textValues.token.count > 8) {
            proceedButton.isEnabled = true
        } else {
            proceedButton.isEnabled = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

