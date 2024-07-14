import Foundation

class Player: Identifiable {
    var id: String
    var nickname: String
    var email: String
    var games: [Game] = []
    
    init(id: String, nickname: String, email: String, games: [Game] = []) {
        self.id = id
        self.nickname = nickname
        self.email = email
        self.games = games
    }
    
//    init?(nickname: String) {
//        self.nickname = nickname
//    }
    
    init?(data: [String: Any]) {
        guard let id = data["id"] as? String,
              let nickname = data["nickname"] as? String,
              let email = data["email"] as? String else { return nil }
        
        self.id = id
        self.nickname = nickname
        self.email = email
    }
    
   
}

extension Player {
    var representation: [String: Any] {
        var repres = [String: Any]()
        repres["id"] = id
        repres["nickname"] = nickname
        repres["email"] = email
        return repres
    }
}


