import UIKit

class JiraUserController: UIViewController {
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var keyTextField: UITextField!
    
    var textValues: (user: String, password: String, url: String, key: String) = ("", "", "", "")
    let TRELLO_STORYBOARD_ID = "JiraMain"
    
    @IBOutlet weak var proceedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTextField.delegate = self
        passwordTextField.delegate = self
        urlTextField.delegate = self
        keyTextField.delegate = self
        
        userTextField.addTarget(self, action: #selector(userFieldDidChange(_:)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(passwordFieldDidChange(_:)), for: .editingChanged)
        urlTextField.addTarget(self, action: #selector(urlFieldDidChange(_:)), for: .editingChanged)
        keyTextField.addTarget(self, action: #selector(keyFieldDidChange(_:)), for: .editingChanged)
        proceedButton.addTarget(self, action: #selector(proceedJiraScreen), for: .touchUpInside)
    }
    
    @objc func proceedJiraScreen() {
        let navigation = self.storyboard?.instantiateViewController(withIdentifier: TRELLO_STORYBOARD_ID) as! JiraController
        navigation.userValues = textValues
        self.navigationController?.pushViewController(navigation, animated: true)
    }
}

extension JiraUserController: UITextFieldDelegate {
    @objc func userFieldDidChange(_ textField: UITextField) {
        textValues.user = textField.text ?? ""
        buttonStatusSpy()
    }
    
    @objc func passwordFieldDidChange(_ textField: UITextField) {
        textValues.password = textField.text ?? ""
        buttonStatusSpy()
    }
    
    @objc func urlFieldDidChange(_ textField: UITextField) {
        textValues.url = textField.text ?? ""
        buttonStatusSpy()
    }
    
    @objc func keyFieldDidChange(_ textField: UITextField) {
        textValues.key = textField.text ?? ""
        buttonStatusSpy()
    }
    
    private func buttonStatusSpy() {
        if textValues.user != "" && textValues.user.count > 8
            && textValues.password != "" && textValues.password.count > 8
            && textValues.url.isValidUrl {
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

