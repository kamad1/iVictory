
import SwiftUI

struct SettingsView: View {
    @StateObject var viewModel: SettingsViewModel
    
    var body: some View {
        VStack {
            HStack {
                TextField("Имя игрока", text: $viewModel.player.nickname)
                Button("Сохранить") {
                    Task {
                        FirestoreService.shared.setPlayerName(id: viewModel.player.id,
                                                              name: viewModel.player.nickname)
                    }
                }
            }
            
            Text("Статистика игр")
            List(viewModel.games) { game in
                StatisticCell(viewModel: .init(game: game))
            }.listStyle(.plain)
            HStack {
                Text("Всего заработано:").bold()
                Spacer()
                Text("\(viewModel.allMoney)₽")
            }
        }.navigationTitle("Настройки и статистика")
            .padding(12)
    }
}

#Preview {
    SettingsView(viewModel: .init(player: .init(id: "", nickname: "Вася Пупкин", email: "vasya@pup.kin")))
}
