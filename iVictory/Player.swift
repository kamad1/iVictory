import Foundation

class Player: Identifiable {
    var id: String
    var nickname: String
    var email: String
    var games: [Game] = []
    
    init(id: String, nickname: String, email: String, games: [Game]) {
        self.id = id
        self.nickname = nickname
        self.email = email
        self.games = games
    }
}

class Game {
    let status: GameStatus
    let date: Date
    let question: Int
    
    var money: Int {
        switch status {
        case .win:
            return 1_000_000
        case .lose:
            return 0
        case .getMoney:
            switch question {
            case 1:  return 100
            case 2:  return 200
            case 3:  return 300
            case 4:  return 400
            case 5:  return 500
            case 6:  return 1000
            case 7:  return 5000
            case 8:  return 10000
            case 9:  return 30000
            case 10: return 50000
            case 11: return 100000
            case 12: return 200000
            case 13: return 300000
            case 14: return 500000
            case 15: return 1000000
            default: return 0
            }
        }
    }
    
    init(status: GameStatus, date: Date, question: Int) {
        self.status = status
        self.date = date
        self.question = question
    }
 
    enum GameStatus: String {
        case win = "Выиграл"
        case lose = "Проиграл"
        case getMoney = "Забрал деньги"
    }
}
