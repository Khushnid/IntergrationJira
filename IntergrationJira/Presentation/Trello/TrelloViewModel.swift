import Foundation
import AtlassianHelper

protocol TrelloViewModelProtocol: AnyObject {

}

class TrelloViewModel {
    var userValues: (key: String, token: String)
    weak var delegate: TrelloViewModelProtocol?
   
    init(userValues: (key: String, token: String)) {
        self.userValues = userValues
    }
    
    lazy var networkManager = DefaultTrelloManager(key: userValues.key,
                                                   token: userValues.token)
    
}
