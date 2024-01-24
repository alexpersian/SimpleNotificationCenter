//  Created by Alex Persian on 1/24/24.
//

import Foundation

/*
 These model definitions are clunky because of a need to use Objc compatible types for
 compliance with NSMapTable / NSHashTable requirements.
 */

// Can be used as-is for weak-reference example.
@objc protocol Observer {
    func notify(for event: Event)
}

// Strong-reference example requires a wrapper since protocols cannot conform
// to Hashable themselves.
struct ObserverWrapper: Hashable {
    let uuid: UUID = UUID()
    let observer: Observer

    init(observer: Observer) {
        self.observer = observer
    }

    static func == (lhs: ObserverWrapper, rhs: ObserverWrapper) -> Bool {
        lhs.uuid == rhs.uuid
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}

class Event: NSObject {
    static let login = Event(type: "login")
    static let logout = Event(type: "logout")
    static let open = Event(type: "open")
    static let close = Event(type: "close")

    let type: String

    init(type: String) {
        self.type = type
    }
}
