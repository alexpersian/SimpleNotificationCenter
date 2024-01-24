//  Created by Alex Persian on 1/24/24.
//

import UIKit
import OSLog

class ViewController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!

    private lazy var notifCenter: Notifier = {
        switch ReferenceTypeChoice {
        case .strong:
            return NotificationCenterStrong.shared
        case .weak:
            return NotificationCenterWeak.shared
        }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        headerLabel.text = ReferenceTypeChoice == .strong ? "Strong References" : "Weak References"
    }

    @IBAction func presentViewOne(_ sender: UIButton) {
        present(color: .systemRed)
    }

    @IBAction func presentViewTwo(_ sender: UIButton) {
        present(color: .systemGreen)
    }

    @IBAction func presentViewThree(_ sender: UIButton) {
        present(color: .systemBlue)
    }

    @IBAction func presentViewFour(_ sender: UIButton) {
        present(color: .systemPurple)
    }

    private func present(color: UIColor) {
        let viewController = ObserverViewController(color: color)
        log(color: color, vc: viewController)
        navigationController?.present(viewController, animated: true)
    }

    private func log(color: UIColor, vc: UIViewController) {
        let address = Unmanaged.passUnretained(vc).toOpaque().debugDescription
        Logger().debug("Presenting view \(color.accessibilityName) (\(address)).")
    }

    @IBAction func sendLogin(_ sender: UIButton) {
        notifCenter.receiveEvent(.login)
    }

    @IBAction func sendLogout(_ sender: UIButton) {
        notifCenter.receiveEvent(.logout)
    }
}
