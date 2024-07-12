
import Foundation

final class GameViewModel: ObservableObject {
    @Published var player: Player

    @Published var questions = [Question]()
    @Published var bank = 0
    @Published var currentQuestionIndex = 0
    
    var currentQuestion: Question {
        guard !questions.isEmpty else {
            return .init(text: "",
                         difficulty: .easy,
                         correctAnswer: "ааа",
                         destructors: ["ббб",
                                       "вввв",
                                       "гггггг"])
        }
        
        return questions[currentQuestionIndex]
    }
    
    var currentQuestionNumber: Int { currentQuestionIndex + 1 }
    
    var price: Int { currentQuestion.difficulty.price }
    
    init(player: Player) {
        self.player = player
        getData()
    }
    
    func getData() {
        
    }
    
    func createGame(status: Game.GameStatus) {
        let game = Game(status: status,
                        date: Date(),
                        question: self.currentQuestionNumber,
                        bank: status == .lose ? 0 : self.bank)
        Task { try await FirestoreService.shared.createGame(game,
                                                            userId: player.id) }
    }
    
    func nextQuestion() {
        //TODO: Переход к следующему вопросу с проверкой, не является ли вопрос последним
        guard !(currentQuestionNumber == 15) else {
            self.createGame(status: .win)
            return
        }
        
        currentQuestionIndex += 1
    }
}
