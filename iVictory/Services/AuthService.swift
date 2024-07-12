
import FirebaseAuth

final class AuthService {
    static let shared = AuthService(); private init() { }
    private let auth = Auth.auth()
    var currentUser: User? { auth.currentUser }
    
    func signUp(email: String,
                password: String) async throws -> User {
        let result = try await auth.createUser(withEmail: email,
                                               password: password)
        try await FirestoreService.shared.createPlayer(id: result.user.uid,
                                             email: result.user.email!)
        return result.user
    }
    
    func signIn(email: String,
                password: String) async throws -> Player {
        let result = try await auth.signIn(withEmail: email,
                                               password: password)
        let player = try await FirestoreService.shared.getPlayer(byId: result.user.uid)
        return player
    }
    
    func sighOut() throws -> Bool {
        try auth.signOut()
        return true
    }
}
