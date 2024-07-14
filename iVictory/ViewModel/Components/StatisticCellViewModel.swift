
import Foundation

class StatisticCellViewModel: ObservableObject {
    let game: Game
    
    init(game: Game) {
        self.game = game
    }
}
