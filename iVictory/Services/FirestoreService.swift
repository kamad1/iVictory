
import FirebaseFirestore

final class FirestoreService {
    static let shared = FirestoreService(); private init() { }
    private let db = Firestore.firestore()
    private var players: CollectionReference { db.collection("players") }
    private var questions: CollectionReference { db.collection("questions") }
    
    //MARK: - Player CRUD
    func createPlayer(id: String, email: String, name: String = "") async throws {
        let player = Player(id: id, nickname: name, email: email)
        try await players.document(id).setData(player.representation)
    }
    
    func getPlayer(byId id: String) async throws -> Player {
        let snapshot = try await players.document(id).getDocument()
        guard let data = snapshot.data() else { throw FirestoreErrorCode(.dataLoss) }
        guard let player = Player(data: data) else { throw FirestoreErrorCode(.invalidArgument) }
        return player
    }
    
    func setPlayerName(id: String, name: String) {
        players.document(id).setData(["nickname": name], merge: true)
    }
    
    //MARK: - Game CRUD
    func createGame(_ game: Game, userId: String) async throws {
        try await players
            .document(userId)
            .collection("games")
            .document(game.id)
            .setData(game.representation)
    }
    
    func getGamesByPlayerID(_ id: String) async throws -> [Game] {
        let documents = try await players
            .document(id)
            .collection("games")
            .getDocuments()
            .documents
            
        let games = documents.compactMap { snap in
            return Game(data: snap.data())
        }
        
        return games
    }
    
    
    //MARK: - Question CRUD
    func createQuestion(_ question: Question) async throws {
        try await questions
            .document(question.id)
            .setData(question.representation)
    }
    // данные метод использовался один раз только для первой загрузки вопросов в базу и более его не используем уже и приватим его
    private func questionsParser() async throws {
        for question in Question.questions {
            try await createQuestion(question)
        }
    }
    
    func getQuestionsForGame() async throws -> [Question] {
        let difficulties = ["Легкий", "Средний", "Сложный"]
        var allQuestions = [Question]()
        
        for difficulty in difficulties {
            let snap = try await questions.whereField("difficulty", isEqualTo: difficulty).getDocuments()
            let docs = snap.documents
            var questions = docs
                .compactMap { snapshot in
                let question = Question(data: snapshot.data())
                return question
            }
                .shuffled()
           
            for num in 0..<5 {
                allQuestions.append(questions[num])
            }
        }
        return allQuestions
    }
}
