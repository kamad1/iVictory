
import SwiftUI

struct GameView: View {
    @StateObject var viewModel: GameViewModel
    @Environment (\.dismiss) var dismiss
    @State private var showStatusMessage = false
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                HStack {
                    Button("Сдаться") {
                        viewModel.status = .getMoney
                    }
                    .padding(8)
                    .background(.darkRed.opacity(0.8))
                    .clipShape(.capsule)
                    .foregroundStyle(.white)
                    Spacer()
                    Text("Банк: \(viewModel.bank)₽")
                }
                .padding(.top, 20)
                Spacer()
                VStack {
                    Text("\(viewModel.currentQuestionNumber)").font(.largeTitle).bold()
                    Text("вопрос")
                }
                .padding(30)
                .background(.darkRed.opacity(0.7))
                .clipShape(.circle)
                
                Text("Цена вопроса: \(viewModel.price)₽")
                Spacer()
                Text(viewModel.currentQuestion.text)
                    .lineLimit(5)
                    .frame(height: 120)
                
                ForEach(viewModel.currentQuestion.answers,
                        id: \.self) { answer in
                    Text(answer)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.purpleButton)
                        .clipShape(.capsule)
                        .onTapGesture {
                            if answer == viewModel.currentQuestion.correctAnswer {
                                print("Переходим к следующему вопросу")
                                viewModel.selectAnswer()
                            } else {
                                print("Вы проиграли!")
                                viewModel.status = .lose
                            }
                        }
                }
                Spacer()
            }
            .foregroundStyle(.white)
        .frame(maxWidth: .infinity,
                maxHeight: .infinity)
        .padding(36)
            
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity)
        .onChange(of: viewModel.status, { _, newValue in
            viewModel.createGame(status: newValue)
            switch newValue {
            case .win:
                viewModel.statusMessage = "Поздравляем! Вы победили! Ваш выигрыш 1 000 000 рублей!"
            case .lose:
                viewModel.statusMessage = "Поздравляем! Вы проиграли! Ваш выигрыш 0 рублей!"
            case .getMoney:
                viewModel.statusMessage = "Вы решили забрать выигрыш. Он составил \(viewModel.bank) рублей!"
            case .inProcess: break
            }
            showStatusMessage = true
        })
        .background(
            Image(.bg)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
            )
        .overlay {
            VStack(spacing: 16) {
                Text(viewModel.statusMessage)
                    .multilineTextAlignment(.center)
                    .bold()
                Button("OK") {
                    self.dismiss()
                }
                .padding(12)
                .padding(.horizontal, 30)
                .background(.purpleButton)
                .tint(.white)
                .clipShape(.capsule)
            }
            .padding()
            .background(.white.opacity(0.9))
            .clipShape(.rect(cornerRadius: 24))
            .frame(maxWidth: 250)
            .offset(y: showStatusMessage ? 0 : -700)
        }
    }
}

#Preview {
    GameView(viewModel: .init(player: .init(id: "", nickname: "", email: "")))
}
