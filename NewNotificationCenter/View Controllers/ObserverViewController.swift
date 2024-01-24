//  Created by Alex Persian on 1/24/24.
//

import UIKit
import OSLog

final class ObserverViewController: UIViewController, Observer {

    private let color: UIColor

    init(color: UIColor) {
        self.color = color
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        let id = color.accessibilityName
        let address = Unmanaged.passUnretained(self).toOpaque().debugDescription
        Logger().debug("View \(id) (\(address)) being deallocated.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = color

        observe(event: .open)
        observe(event: .close)
        observe(event: .login)
        observe(event: .logout)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        switch ReferenceTypeChoice {
        case .strong:
            NotificationCenterStrong.shared.receiveEvent(.open)
        case .weak:
            NotificationCenterWeak.shared.receiveEvent(.open)
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        switch ReferenceTypeChoice {
        case .strong:
            NotificationCenterStrong.shared.receiveEvent(.close)
        case .weak:
            NotificationCenterWeak.shared.receiveEvent(.close)
        }
    }

    private func observe(event: Event) {
        switch ReferenceTypeChoice {
        case .strong:
            NotificationCenterStrong.shared.addObserver(ObserverWrapper(observer: self), for: event)
        case .weak:
            NotificationCenterWeak.shared.addObserver(self, for: event)
        }
    }

    func notify(for event: Event) {
        let id = color.accessibilityName
        let address = Unmanaged.passUnretained(self).toOpaque().debugDescription
        Logger().debug("View \(id) (\(address)) was notified for event (\(event.type))")
    }
}
