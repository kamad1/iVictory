
import SwiftUI

struct GameView: View {
    @StateObject var viewModel: GameViewModel
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                HStack {
                    Button("Сдаться") {
                        viewModel.createGame(status: .getMoney)
                        dismiss()
                    }
                    .padding(8)
                    .background(.darkRed.opacity(0.8))
                    .clipShape(.capsule)
                    .foregroundStyle(.white)
                    Spacer()
                    Text("Банк: 0₽")
                }
                .padding(.top, 20)
                Spacer()
                VStack {
                    Text("1").font(.largeTitle).bold()
                    Text("вопрос")
                }
                .padding(30)
                .background(.darkRed.opacity(0.7))
                .clipShape(.circle)
                
                Text("Цена вопроса: 30000₽")
                Spacer()
                Text("Здесь будет наверное даже очень длинный текст вопроса или всё-таки не будет?")
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
                            } else {
                                print("Вы проиграли!")
                                viewModel.createGame(status: .lose)
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
        .background(
            Image(.bg)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
            )
    }
}

#Preview {
    GameView(viewModel: .init(player: .init(id: "", nickname: "", email: "")))
}
