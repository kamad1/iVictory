
import Foundation

class MainMenuViewModel: ObservableObject {
    let currentUserID: String
    @Published var authorized = true
    
    init(userId: String) {
        self.currentUserID = userId
        getData()
    }
    
    func getData() {
        
    }
    
    func quit() {
        let result = try! AuthService.shared.sighOut()
        guard result == true else {
            print("ERROER!")
            return }
        self.authorized = false
    }
}
