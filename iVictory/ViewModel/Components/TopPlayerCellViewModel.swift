
import Foundation

class TopPlayerCellViewModel: ObservableObject {
    let player: Player
    
    init(player: Player) {
        self.player = player
    }
}
