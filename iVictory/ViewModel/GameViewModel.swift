
import Foundation

final class GameViewModel: ObservableObject {
    @Published var player: Player
    @Published var questions = [Question]()
    @Published var bank = 0
    @Published var currentQuestionIndex = 0
    @Published var status: Game.GameStatus = .inProcess
    @Published var statusMessage = ""
    
    var currentQuestion: Question {
        guard !questions.isEmpty else {
            return .init(text: "",
                         correctAnswer: "ааа",
                         destructors: ["ббб",
                                       "вввв",
                                       "гггггг"],
                         difficulty: .easy
            )
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
        Task {
            let questions = try await  FirestoreService.shared.getQuestionsForGame()
            print("Questions: \(questions.count)")
            DispatchQueue.main.async {
                self.questions = questions
            }
        }
       
    }
    
    func createGame(status: Game.GameStatus) {
        let game = Game(status: status,
                        date: Date(),
                        question: self.currentQuestionNumber,
                        bank: status == .lose ? 0 : self.bank)
        Task { try await FirestoreService.shared.createGame(game,
                                                            userId: player.id) }
    }
    
    func selectAnswer() {
        //TODO: Переход к следующему вопросу с проверкой, не является ли вопрос последним
        guard !(currentQuestionNumber == 15) else {
            self.status = .win
            return
        }
        bank += price
        currentQuestionIndex += 1
    }
    
  
}

