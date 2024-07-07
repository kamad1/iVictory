import SwiftUI

struct MainMenuView: View {
    @StateObject var viewModel: MainMenuViewModel
    @EnvironmentObject var contentVM: ContentViewModel
    var body: some View {
        
        VStack {
            Text(viewModel.currentUserID)
            Button("Выйти") {
                viewModel.quit()
            }
        }
        .onChange(of: viewModel.authorized) { oldValue, newValue in
            if newValue == false {
                contentVM.appState = .unauthorized
            }
        }
        
    }
}

#Preview {
    ContentView()
}
