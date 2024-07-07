
import FirebaseAuth

class AuthService {
    static let shared = AuthService(); private init() { }
    private let auth = Auth.auth()
    var currentUser: User? { auth.currentUser }
    
    func signUp(email: String,
                password: String) async throws -> User {
        let result = try await auth.createUser(withEmail: email,
                                               password: password)
        return result.user
    }
    
    func signIn(email: String,
                password: String) async throws -> User {
        let result = try await auth.signIn(withEmail: email,
                                               password: password)
        return result.user
    }
    
    func sighOut() throws -> Bool {
        try auth.signOut()
        return true
    }
}



