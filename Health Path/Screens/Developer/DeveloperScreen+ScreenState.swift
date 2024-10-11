
import Foundation

extension DeveloperScreen {
    
    enum ScreenState: Equatable {
        
        // MARK: - Cases
        
        case initial
        case servers(_ servers: [Server])
    }
}
