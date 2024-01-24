//  Created by Alex Persian on 1/24/24.
//

import Foundation

enum ReferenceType {
    case strong
    case weak
}

/// Change this between .strong and .weak to observe the difference in
/// observer retention behavior.
let ReferenceTypeChoice: ReferenceType = .strong
