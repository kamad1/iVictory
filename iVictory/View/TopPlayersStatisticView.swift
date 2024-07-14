//
//  TopPlayersStatisticView.swift
//  iVictory
//
//  Created by Jedi on 14.07.2024.
//

import SwiftUI

struct TopPlayersStatisticView: View {
    @StateObject var viewModel: TopPlayersStatisticViewModel
    
    var body: some View {
        VStack {
            Text("Статистика ИГРОКОВ")
            TopPlayerCell(viewModel: .init(player: .init(id: "\(viewModel.player.id)", nickname: "", email: "")))
            HStack {
                Text("Всего заработано:").bold()
                Spacer()
                Text("\(viewModel.allMoney)₽")
            }
        }
    }
}

//#Preview {
//    TopPlayersStatisticView(viewModel: .init(player: player))
//}
