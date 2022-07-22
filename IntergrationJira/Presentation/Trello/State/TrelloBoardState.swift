import Foundation

enum TrelloBoardState {
    case boards
    case lists
    case cards
    
    var trelloState: String {
        switch self {
        case .boards: return ""
        case .lists: return ""
        case .cards: return ""
        }
    }
}

