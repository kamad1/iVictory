
import Foundation

final class MainMenuViewModel: ObservableObject {
    let currentUserId: String
    @Published var authorized = true
    var player: Player?
    
    init(id: String) {
        self.currentUserId = id
        getData()
    }
    
    func getData() {
        Task {
            let player = try await FirestoreService.shared.getPlayer(byId: currentUserId)
            DispatchQueue.main.async {
                self.player = player
            }
        }
    }
    
    func quit() {
        let result = try! AuthService.shared.sighOut()
        guard result == true else {
            print("ERROER!")
            return }
        self.authorized = false
    }
}
