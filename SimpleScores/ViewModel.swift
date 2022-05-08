//
//  ViewModel.swift
//  SimpleToDo
//
//  Created by Tomasz Ogrodowski on 08/05/2022.
//

import Combine
import Foundation

protocol ViewModelStoring: Codable, Identifiable, Hashable {
    init() 
}

/// Generic ViewModel
class ViewModel<ItemType: ViewModelStoring>: ObservableObject {
    @Published var items: [ItemType]

    private let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedItems")

    private var saveSubscription: AnyCancellable?

    init() {
        do {
            let data = try Data(contentsOf: savePath)
            items = try JSONDecoder().decode([ItemType].self, from: data)
        } catch let error {
            items = []
            print("Error decoding data: \(error.localizedDescription)")
        }

        addSubscribers()
    }

    func addSubscribers() {
        saveSubscription = $items
            .debounce(for: 5, scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.save()
            }
    }

    func save() {
        do {
            let data = try JSONEncoder().encode(items)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch let error {
            print("Unable to save data: \(error.localizedDescription)")
        }
    }

    // swipe to delete
    func delete(_ offsets: IndexSet) {
        items.remove(atOffsets: offsets)
    }

    func deleteAll() {
        items.removeAll()
    }
}

/// Local changes to fit our exact project 
extension ViewModel where ItemType == Score {

    func add() {
        let usedColors = items.map(\.color) // Taking only 'color' values from items in array
        let color = ColorChoice.allCases.first { usedColors.contains($0) == false } ?? .blue // if the usedColors doesn't contain the value of certain color from ColorChoice pick it
        let newItem = Score(color: color)
        items.append(newItem)
    }

    func reset() {
        for i in 0..<items.count {
            items[i].score = 0
        }
    }
}
