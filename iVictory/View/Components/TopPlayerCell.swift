//
//  TopPlayerCell.swift
//  iVictory
//
//  Created by Jedi on 14.07.2024.
//

import SwiftUI

struct TopPlayerCell: View {
    @StateObject var viewModel: TopPlayerCellViewModel
    
    var body: some View {
        HStack {

            Text(viewModel.player.nickname)
                .frame(width: 120, alignment: .leading)
            Spacer()
            Text("\(viewModel.player.games.count)")
                .frame(width: 100, alignment: .trailing)
        }
    }
}


#Preview {
    TopPlayerCell(viewModel: .init(player: .init(id: "", nickname: "sd", email: "sd")))
}
