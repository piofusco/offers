//
// Created by gideon on 10/27/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import Foundation

protocol DataStore: class {
    associatedtype T where T: Codable

    func elements() -> [T]
    func element(id: String) -> T?
    func update(element: T)
}

protocol Idable {
    var id: String { get }
}

class DataStoreImplementation<Element>: DataStore where Element: Codable & Idable {
    typealias T = Element
    private var offersInMemory: [T] = []

    init() {
        if let path = Bundle.main.path(forResource: "offers", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                offersInMemory = try JSONDecoder().decode([T].self, from: data)
            } catch {
                print("could not load initial json: \(error.localizedDescription)")
            }
        }
    }

    func element(id: String) -> T? {
        offersInMemory.first {
            $0.id == id
        }
    }

    func elements() -> [T] {
        offersInMemory
    }

    func update(element: T) {
        guard let index = offersInMemory.firstIndex(where: { $0.id == element.id }) else {
            return
        }
        offersInMemory[index] = element
    }
}