//
//  Score.swift
//  SimpleScores
//
//  Created by Tomasz Ogrodowski on 08/05/2022.
//

import Foundation

struct Score: ViewModelStoring {
    var id = UUID()
    var playerName = "New Player"
    var score = 0
    var color = ColorChoice.blue

    static let example = Score()
}
