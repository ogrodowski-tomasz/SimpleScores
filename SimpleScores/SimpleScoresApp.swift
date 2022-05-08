//
//  SimpleScoresApp.swift
//  SimpleScores
//
//  Created by Tomasz Ogrodowski on 08/05/2022.
//

import SwiftUI

@main
struct SimpleScoresApp: App {
    @StateObject var model = ViewModel<Score>()
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(model: model)
            }
            .navigationViewStyle(.stack)
            .preferredColorScheme(.dark)
        }
        .onChange(of: scenePhase) { phase in
            if phase == .background {
                model.save()
            }
        }
    }
}
