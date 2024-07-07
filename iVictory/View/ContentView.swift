import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        switch viewModel.appState {
        case .unauthorized:
            AuthView()
                .environmentObject(viewModel)
        case .authorized(let id):
            let viewModel = MainMenuViewModel(userId: id)
            MainMenuView(viewModel: viewModel)
                .environmentObject(self.viewModel)
        }
    }
}

#Preview {
    ContentView()
}
