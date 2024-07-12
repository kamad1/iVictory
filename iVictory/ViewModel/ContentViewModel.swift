
import Foundation

final class ContentViewModel: ObservableObject {
    @Published var appState: AppState
    
    init() {
        if let user = AuthService.shared.currentUser {
            appState = .authorized(id: user.uid)
        } else {
            appState = .unauthorized
        }
    }
}


enum AppState {
    case unauthorized
    case authorized(id: String)
}
