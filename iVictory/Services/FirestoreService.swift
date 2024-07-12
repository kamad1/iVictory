
import FirebaseFirestore

final class FirestoreService {
    static let shared = FirestoreService(); private init() { }
    private let db = Firestore.firestore()
    private var players: CollectionReference { db.collection("players") }
    
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
    
    func createGame(_ game: Game, userId: String) async throws {
        try await players
            .document(userId)
            .collection("games")
            .document(game.id)
            .setData(game.representation)
    }
}
