
import Foundation

import FirebaseFirestore

class Game: Identifiable {
    let id: String
    let status: GameStatus
    let date: Date
    let question: Int
    let bank: Int
    
    init(status: GameStatus, date: Date, question: Int, bank: Int, id: String = UUID().uuidString) {
        self.status = status
        self.date = date
        self.question = question
        self.bank = bank
        self.id = id
    }
 
    enum GameStatus: String {
        case win = "Выиграл"
        case lose = "Проиграл"
        case getMoney = "Забрал деньги"
    }
    
}

extension Game {
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = id
        repres["status"] = status.rawValue
        repres["bank"] = bank
        repres["question"] = question
        let timeStamp = Timestamp(date: self.date)
        repres["date"] = timeStamp
        return repres
    }
}
