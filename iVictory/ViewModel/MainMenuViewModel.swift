
import Foundation

final class MainMenuViewModel: ObservableObject {
    let currentUserId: String
    @Published var authorized = true
    @Published var player: Player?
    @Published var imageData: Data?
    init(id: String) {
        self.currentUserId = id
        getData()
        downloadPP()
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
    
    func uploadImage(data: Data) {
        Task {
            try await StorageService.shared.upload(data: data, for: currentUserId)
        }
    }
    // метод загрузки своей картинки
    func downloadPP() {
        Task {
           let data = try await StorageService.shared.downloadPP(byUserID: currentUserId)
            DispatchQueue.main.async {
                self.imageData = data
            }
        }
    }
    
}
