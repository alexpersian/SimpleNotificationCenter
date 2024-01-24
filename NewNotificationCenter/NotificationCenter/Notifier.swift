//  Created by Alex Persian on 1/24/24.
//

import Foundation

// TODO: Expand on this protocol to cover all the NotificationCenter behavior
protocol Notifier {
    func receiveEvent(_ event: Event)
}
