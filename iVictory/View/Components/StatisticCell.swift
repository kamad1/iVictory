
import SwiftUI

struct StatisticCell: View {
    @StateObject var viewModel: StatisticCellViewModel
    
    var body: some View {
        HStack {
            Text(DateHelper.shared.dateToString(viewModel.game.date)).bold()
            Spacer()
            Text(viewModel.game.status.rawValue)
                .frame(width: 120, alignment: .leading)
            Spacer()
            Text("\(viewModel.game.bank) ₽").bold()
                .frame(width: 100, alignment: .trailing)
        }
    }
}

#Preview {
    StatisticCell(viewModel: .init(game: Game(status: .getMoney,
                                              date: Date(),
                                              question: 15,
                                              bank: 1000000)))
}
