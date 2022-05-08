//
//  ContentView.swift
//  SimpleScores
//
//  Created by Tomasz Ogrodowski on 08/05/2022.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var model: ViewModel<Score>

    @State private var showingClearAlert = false

    var body: some View {
        List {
            ForEach($model.items, content: ScoreRow.init)
                .onDelete(perform: model.delete)

            Button {
                model.add()
            } label: {
                Label("Add Player", systemImage: "plus")
                    .font(.title.bold())
                    .frame(maxWidth: .infinity, minHeight: 44)
                    .contentShape(Rectangle())
            }
            .disabled(model.items.count == ColorChoice.allCases.count)
            .listRowSeparator(.hidden)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    model.reset()
                } label: {
                    Label("Reset Scors to 0", systemImage: "arrow.counterclockwise")
                }
                .disabled(model.items.isEmpty)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingClearAlert = true
                } label: {
                    Label("Remove All", systemImage: "trash")
                }
                .disabled(model.items.isEmpty)
            }
        }
        .alert("Delete all players?", isPresented: $showingClearAlert) {
            Button("Delete", role: .destructive, action: model.deleteAll)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("This will immediately remove all players and their scores")
        }
        .animation(.default, value: model.items)
        .navigationTitle("SimpleScores")
        .listStyle(.plain)
        .buttonStyle(.plain)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(model: ViewModel<Score>())
    }
}
