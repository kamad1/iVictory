
import Foundation

final class AuthViewModel: ObservableObject {
    @Published var userId: String? = nil
    
    func createAccount(login: String,
                       password: String,
                       confirm: String) {
        guard password == confirm else {
            print("Пароли не совпадают")
            return
        }
        Task {
            let user = try await AuthService.shared.signUp(email: login,
                                                    password: password)
            DispatchQueue.main.async {
                self.userId = user.uid
            }
        }
    }
    
    func authorization(login: String,
                       password: String) {
        Task {
            let player = try await AuthService.shared.signIn(email: login,
                                                    password: password)
            DispatchQueue.main.async {
                self.userId = player.id
            }
        }
    }
}
