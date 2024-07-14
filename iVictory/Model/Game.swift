
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
    
    init?(data: [String: Any]) {
        guard let id = data["id"] as? String,
              let bank = data["bank"] as? Int,
              let question = data["question"] as? Int,
              let timestamp = data["date"] as? Timestamp,
              let statusRawValue = data["status"] as? String else { return nil }
        
        let date = timestamp.dateValue()
        guard let status = Game.GameStatus(rawValue: statusRawValue) else { return nil }
        
        self.id = id
        self.bank = bank
        self.question = question
        self.date = date
        self.status = status
    }
 
    enum GameStatus: String {
        case win = "Выиграл"
        case lose = "Проиграл"
        case getMoney = "Забрал деньги"
        case inProcess = "В процессе"
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
