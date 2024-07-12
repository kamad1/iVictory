import SwiftUI

struct AuthView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirm: String = ""
    @State private var isAuth: Bool = true
    @StateObject var viewModel = AuthViewModel()
    @EnvironmentObject var contentVM: ContentViewModel
    
    var body: some View {
        VStack(spacing: 36) {
            Text("iVictory")
                .font(.title)
              
                .padding(.vertical)
                .padding(.horizontal, 30)
                .background(.black.opacity(0.3))
                .clipShape(.capsule)
            VStack(spacing: 16) {
                Text(isAuth ? "Авторизация" : "Регистрация")
                    .font(.title3.bold())
                TextField("Введите Email", text: $email)
                    .padding(12)
                    .background(.white.opacity(0.8))
                    .clipShape(.capsule)
                SecureField("Введите пароль", text: $password)
                    .padding(12)
                    .background(.white.opacity(0.8))
                    .clipShape(.capsule)
                if !isAuth {
                    SecureField("Повторите пароль", text: $confirm)
                        .padding(12)
                        .background(.white.opacity(0.8))
                        .clipShape(.capsule)
                }
                Button(isAuth ? "Войти" : "Создать аккаунт") {
                    switch isAuth {
                    case true: viewModel.authorization(login: email,
                                                       password: password)
                    case false: viewModel.createAccount(login: email,
                                                        password: password,
                                                        confirm: confirm)
                    }
                }
                .modifier(CapsuledButton(color: .purple))
                
                Button(isAuth ? "Ещё не с нами?" : "Уже есть аккаунт?") {
                    isAuth.toggle()
                }
            }
            .frame(width: isAuth ? 240 : 280)
            .padding(24)
            .background(.black.opacity(0.3))
            .clipShape(.rect(cornerRadius: 24))
        }
        .onChange(of: viewModel.userId, { oldValue, newValue in
            guard let newValue else {
                contentVM.appState = .unauthorized
                return
            }
            contentVM.appState = .authorized(id: newValue)
        })
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity,maxHeight: .infinity)
        .offset(y: -70)
        .background {
            Image(.bg)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .blur(radius: isAuth ? 0 : 16,
                      opaque: true)
        }
        .animation(.easeInOut(duration: 0.3), value: isAuth)
    }
}

#Preview {
    AuthView()
}
