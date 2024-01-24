//  Created by Alex Persian on 1/24/24.
//

import Foundation

/// Class that demonstrates the observer pattern with weakly held references to
/// observers. This showcases a way to avoid retain cycles.
final class NotificationCenterWeak: Notifier {

    public static let shared: NotificationCenterWeak = NotificationCenterWeak()
    private init() {}

    // MARK: - Weak observer references

    typealias Observers = NSHashTable<Observer>
    typealias ObserverList = NSMapTable<Event, Observers>

    // We use .strongMemory for both key&value here because otherwise the newly created NSHashTable is deallocated immediately
    // since there are no strong references to it. The observers within the NSHashTable are weakly referenced, so no reference cycle is created.
    private var observerList: ObserverList = NSMapTable(keyOptions: .strongMemory, valueOptions: .strongMemory)

    func addObserver(_ observer: any Observer, for event: Event) {
        if let observers = observerList.object(forKey: event) {
            observers.add(observer)
        }
        else {
            // We use .weakMemory here so that the NSHashTable only holds a weak reference to the observers
            let observers = Observers(options: .weakMemory)
            observers.add(observer)
            observerList.setObject(observers, forKey: event)
        }
    }

    func removeObserver(_ observer: any Observer, for event: Event) {
        if let observers = observerList.object(forKey: event) {
            observers.remove(observer)
        }
    }

    func receiveEvent(_ event: Event) {
        if let observers = observerList.object(forKey: event) {
            observers.allObjects.forEach { $0.notify(for: event) }
        }
    }
}
