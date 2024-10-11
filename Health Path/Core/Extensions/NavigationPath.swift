
import SwiftUI

extension NavigationPath {
    
    mutating func popToRoot() { removeLast(count) }
}
