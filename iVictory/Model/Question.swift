
import Foundation

class Question: Identifiable {
    let id: String
    let text: String
    let difficulty: Difficulty
    let correctAnswer: String
    var destructors: [String]
    
    var answers: [String] {
        var ans = destructors
        ans.append(correctAnswer)
        return ans.shuffled()
    }
    
    init(id: String = UUID().uuidString,
         text: String,
         difficulty: Difficulty,
         correctAnswer: String,
         destructors: [String]) {
        self.text = text
        self.difficulty = difficulty
        self.correctAnswer = correctAnswer
        self.destructors = destructors
        self.id = id
    }
}

enum Difficulty: String {
    case easy = "Легкий"
    case medium = "Средний"
    case hard = "Сложный"
    
    var price: Int {
        switch self {
        case .easy: return 10000
        case .medium: return 50000
        case .hard: return 140000
        }
    }
}
