//
//  ScoreRow.swift
//  SimpleScores
//
//  Created by Tomasz Ogrodowski on 08/05/2022.
//

import SwiftUI

struct ScoreRow: View {

    @Binding var item: Score

    var body: some View {
        HStack(spacing: 10) {
            Button {
                item.score -= 1
            } label: {
                Image(systemName: "minus")
                    .font(.title3.weight(.black))
                    .frame(minWidth: 44, minHeight: 44) // required min size of touchable content
                    .contentShape(Rectangle())
            }

            TextField("Player Name", text: $item.playerName)
                .font(.title.weight(.black))
                .minimumScaleFactor(0.75)
                .frame(maxWidth: .infinity, alignment: .leading)
                .submitLabel(.done)

            Text(String(item.score))
                .font(.title.weight(.black))

            Button {
                item.score += 1
            } label: {
                Image(systemName: "plus")
                    .font(.title3.weight(.black))
                    .frame(minWidth: 44, minHeight: 44) // required min size of touchable content
                    .contentShape(Rectangle())
            }
        }
        .padding(10)
        .animation(nil, value: item)
        .background(Color(item.color.rawValue))
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
        .accessibilityElement() // whole hstack is one element for VoiceOver
        .accessibilityLabel(item.playerName)
        .accessibilityValue(String(item.score)) // When score is upgrated VoiceOver reads only the score value without Player's name
        .accessibilityHint("Activate to rename this player.")
        .accessibilityAddTraits(.isButton)
        .accessibilityAdjustableAction { direction in
            if direction == .increment {
                item.score += 1
            } else {
                item.score -= 1
            }
        }
    }
}

struct ScoreRow_Previews: PreviewProvider {
    static var previews: some View {
        ScoreRow(item: .constant(.example))
    }
}
