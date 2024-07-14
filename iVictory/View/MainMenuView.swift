import SwiftUI

struct MainMenuView: View {
    @StateObject var viewModel: MainMenuViewModel
    @EnvironmentObject var contentVM: ContentViewModel
    @State private var showGameView = false
    
    var body: some View {
        
        VStack {
            VStack(spacing: 30) {
                Text("iVictory")
                    .font(.title)
                    .foregroundStyle(.white)
                    .bold()
                
                Button("Старт!") {
                    showGameView.toggle()
                }
                .modifier(CapsuledButton(color: .purple))
                
                NavigationLink("Настройки") {
                    if let player = viewModel.player {
                        SettingsView(viewModel: .init(player: player))
                    }
                        
                }
                .modifier(CapsuledButton(color: .orange))
                
                Button("Выйти") {
                    viewModel.quit()
                }
                .modifier(CapsuledButton(color: .red))
                
                NavigationLink("ТОП Игроков") {
                    Text("ТОП Игроков")
                    if let player = viewModel.player {
                        TopPlayersStatisticView(viewModel: .init(player: player))
                    }
                    
                    
                }
                .modifier(CapsuledButton(color: .green))

               
            }
            .onChange(of: viewModel.authorized) { oldValue, newValue in
                if newValue == false {
                    contentVM.appState = .unauthorized
                }
            }
            .frame(width: 280)
        }
        .tint(.white)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Image(.bg)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
        )
        .fullScreenCover(isPresented: $showGameView, content: {
            if let player = viewModel.player {
                GameView(viewModel: .init(player: player))
            }
        })
    }
}

#Preview {
    ContentView()
}



