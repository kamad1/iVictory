
import Foundation

class SettingsViewModel: ObservableObject {
    @Published var player: Player
    @Published var games: [Game] = []
    var allMoney: Int {
        games.reduce(0) { partialResult, game in
            partialResult + game.bank
        }
    }
    
    init(player: Player) {
        self.player = player
        getData()
    }
    
    func getData() {
        Task {
            let games = try await FirestoreService.shared.getGamesByPlayerID(player.id)
            DispatchQueue.main.async {
                self.games = games.sorted(by: { left, right in
                    left.date > right.date
                })
            }
        }
    }
}
