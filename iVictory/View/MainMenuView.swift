import SwiftUI
import PhotosUI

struct MainMenuView: View {
    @StateObject var viewModel: MainMenuViewModel
    @EnvironmentObject var contentVM: ContentViewModel
    @State private var showGameView = false
    @State private var ppItem: PhotosPickerItem?
    @State private var ppImage = Image(systemName: "person.circle")
    
    var body: some View {
        
        VStack {
            VStack(spacing: 30) {
                Text("iVictory")
                    .font(.title)
                    .foregroundStyle(.white)
                    .bold()
                
                VStack(spacing: 15) {
                    PhotosPicker(selection: $ppItem,
                                 matching: .images) {
                        ppImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(.circle)
                            .fontWeight(.light)
                    }
                    Text(viewModel.player?.nickname ?? "")
                        .font(.title2).bold()
                }.foregroundStyle(.white)
                
                Button("Старт!") {
                    showGameView.toggle()
                }
                .modifier(CapsuledButton(color: .purple))
                .onChange(of: viewModel.imageData) {
                    if let imageData = viewModel.imageData,
                       let uiimage = UIImage(data: imageData) {
                        self.ppImage = Image(uiImage: uiimage)
                    }
                    
                }
                //обвертка что бы при изменении картинки она летела в базу и сохранялась onChange
                .onChange(of: ppItem) {
                    Task {
                        if let loadedImage = try? await ppItem?.loadTransferable(type: Data.self) {
                            viewModel.imageData = loadedImage
                            if let uiimage = UIImage(data: viewModel.imageData!) {
                                
                                let image = Image(uiImage: uiimage)
                                self.ppImage = image
                                // отправляем в сторадж картинку
                                viewModel.uploadImage(data: loadedImage)
                            }
                        }
                    }
                }
                
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



