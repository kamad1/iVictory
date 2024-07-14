import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        switch viewModel.appState {
        case .unauthorized:
            AuthView()
                .environmentObject(viewModel)
        case .authorized(let player):
            let viewModel = MainMenuViewModel(id: player)
            NavigationView {
                MainMenuView(viewModel: viewModel)
                    .environmentObject(self.viewModel)
                // это нужно сделать только 1 раз для загрузки вопросов после 1 запуска комитим или удаляем, а метод в сервисе делаем приватным что бы к нему не обращаться более.
                //                    .onAppear {
                //                        Task {
                //                            try await FirestoreService.shared.questionsParser()
                //                        }
                //                    }
            }
        }
    }
}

#Preview {
    ContentView()
}
