//  Created by Alex Persian on 1/24/24.
//

import Foundation

/// Class that demonstrates the observer pattern with strongly held references to
/// observers. This showcases the issues with retain cycles.
final class NotificationCenterStrong: Notifier {

    public static let shared: NotificationCenterStrong = NotificationCenterStrong()
    private init() {}

    // MARK: - Strong observer references

    typealias Observers = Set<ObserverWrapper>
    typealias ObserverList = Dictionary<Event, Observers>

    private var observerList: ObserverList = [:]

    func addObserver(_ observer: ObserverWrapper, for event: Event) {
        if observerList[event] == nil {
            observerList[event] = [observer]
        } 
        else {
            observerList[event]?.insert(observer)
        }
    }

    func removeObserver(_ observer: ObserverWrapper, for event: Event) {
        observerList[event]?.remove(observer)
    }

    func receiveEvent(_ event: Event) {
        observerList[event]?.forEach { $0.observer.notify(for: event) }
    }
}
